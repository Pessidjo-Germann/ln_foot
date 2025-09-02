import 'dart:async';
import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:keycloak_wrapper/keycloak_wrapper.dart';
import 'package:ln_foot/user_session_manager.dart';
import 'package:ln_foot/model/logout_result.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthService {
  final KeycloakWrapper _keycloak;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;
  Timer? _refreshTimer;

  AuthService._(this._keycloak);

  static Future<AuthService> create() async {
    final wrapper = KeycloakWrapper(
      config: KeycloakConfig(
        bundleIdentifier: 'com.lnfoot',
        clientId: 'ln-foot-01',
        frontendUrl: 'https://auth.ln-foot.com',
        realm: 'lnfoot',
      ),
    );
    await wrapper.initialize();
    return AuthService._(wrapper);
  }

  Stream<bool> get authStream => _keycloak.authenticationStream;

  Future<bool> login() async {
    final result = await _keycloak.login();
    if (result) {
      final token = _keycloak.accessToken;
      final userInfo = await _keycloak.getUserInfo();

      // Stocker le token de façon sécurisée
      if (token != null) {
        await _secureStorage.write(key: 'access_token', value: token);
        debugPrint('Token stocké de façon sécurisée');
      }

      // Planifier le refresh automatique
      final expirationTime = _keycloak.tokenResponse?.accessTokenExpirationDateTime;
      if (expirationTime != null && _keycloak.refreshToken != null) {
        final expiresInSeconds = expirationTime.difference(DateTime.now()).inSeconds;
        debugPrint("Token expire dans : $expiresInSeconds secondes");
        scheduleTokenRefresh(expiresInSeconds, _keycloak.refreshToken!);
      }

      // Stocker les infos utilisateur
      if (userInfo != null) {
        await UserSessionManager.saveAuthenticatedUserData(userInfo: userInfo, accessToken: token!, refreshToken: _keycloak.refreshToken!);
      }
    }
    return result;
  }

  // AMÉLIORATION: Vérification JWT robuste
  Future<bool> isTokenValid() async {
    final token = await getAccessToken();
    if (token == null || token.isEmpty) return false;

    try {
      // Décoder le JWT pour vérifier l'expiration
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
      );

      final exp = payload['exp'] as int?;
      if (exp == null) return false;

      final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      // Considérer le token invalide 2 minutes avant l'expiration
      final buffer = const Duration(minutes: 2);
      return DateTime.now().isBefore(expirationDate.subtract(buffer));
    } catch (e) {
      debugPrint('Erreur lors de la validation du token: $e');
      return false;
    }
  }

  // AMÉLIORATION: Refresh intelligent
  Future<bool> refreshTokenIfNeeded() async {
    // Si le token est encore valide, pas besoin de refresh
    if (await isTokenValid()) {
      debugPrint('Token encore valide, pas de refresh nécessaire');
      return true;
    }

    debugPrint('Token expiré ou proche de l\'expiration, refresh nécessaire');
    return await refreshToken();
  }

  // AMÉLIORATION: Planification optimisée
  void scheduleTokenRefresh(int expiresInSeconds, String refreshTokenValue) {
    // Annuler le timer précédent s'il existe
    _refreshTimer?.cancel();

    // Calculer quand rafraîchir (2 minutes avant expiration, minimum 1 minute)
    final refreshInSeconds = (expiresInSeconds - 120).clamp(60, expiresInSeconds);
    final refreshDuration = Duration(seconds: refreshInSeconds);

    debugPrint('Planification du refresh dans ${refreshDuration.inMinutes} minutes');

    _refreshTimer = Timer(refreshDuration, () async {
      debugPrint('Exécution du refresh automatique planifié');
      if (await refreshTokenIfNeeded()) {
        // Re-planifier si le refresh a réussi
        final newExpirationTime = _keycloak.tokenResponse?.accessTokenExpirationDateTime;
        if (newExpirationTime != null && _keycloak.refreshToken != null) {
          final newExpiresInSeconds = newExpirationTime.difference(DateTime.now()).inSeconds;
          if (newExpiresInSeconds > 120) {
            scheduleTokenRefresh(newExpiresInSeconds, _keycloak.refreshToken!);
          }
        }
      } else {
        debugPrint('Refresh automatique échoué, arrêt de la planification');
      }
    });
  }

  Future<bool> refreshToken() async {
    if (_isRefreshing) {
      debugPrint('Refresh déjà en cours, attente du résultat...');
      return _refreshCompleter!.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      debugPrint('Début du refresh token via Keycloak...');
      
      // Utiliser updateToken avec une marge de 5 minutes
      await _keycloak.updateToken(const Duration(minutes: 5));

      final newAccessToken = _keycloak.accessToken;
      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        // Stocker le nouveau token
        await _secureStorage.write(key: 'access_token', value: newAccessToken);
        debugPrint('Nouveau token stocké avec succès');

        // Re-planifier le prochain refresh
        final expirationTime = _keycloak.tokenResponse?.accessTokenExpirationDateTime;
        if (expirationTime != null && _keycloak.refreshToken != null) {
          final expiresInSeconds = expirationTime.difference(DateTime.now()).inSeconds;
          scheduleTokenRefresh(expiresInSeconds, _keycloak.refreshToken!);
        }

        _refreshCompleter!.complete(true);
        return true;
      } else {
        debugPrint('Nouveau token vide après refresh');
        _refreshCompleter!.complete(false);
        return false;
      }
    } catch (e, s) {
      debugPrint('Erreur lors du refresh token: $e');
      debugPrint('Stack trace: $s');

      // En cas d'erreur critique, déconnecter l'utilisateur
      debugPrint('Refresh échoué, déconnexion de l\'utilisateur');
      await logout();
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<LogoutResult> logout() async {
    return await logoutWithTimeout();
  }

  Future<LogoutResult> logoutWithTimeout() async {
    try {
      return await _performLogout().timeout(
        const Duration(seconds: 10),
        onTimeout: () async {
          debugPrint('Timeout lors de la déconnexion - nettoyage local uniquement');
          await _cleanLocalData();
          return LogoutResult.error('Timeout de déconnexion', LogoutType.localOnly);
        },
      );
    } catch (e) {
      debugPrint('Erreur inattendue lors de la déconnexion: $e');
      await _cleanLocalData();
      return LogoutResult.error('Erreur inattendue: $e', LogoutType.localOnly);
    }
  }

  Future<LogoutResult> _performLogout() async {
    // Annuler le timer de refresh dès le début
    _cancelRefreshTimer();
    
    try {
      // Vérifier la connectivité réseau
      final hasConnection = await _checkConnectivity();
      
      if (hasConnection) {
        debugPrint('Connexion réseau disponible - déconnexion complète');
        
        try {
          // Tentative de déconnexion Keycloak
          await _keycloak.logout();
          await _cleanLocalData();
          return LogoutResult.success(LogoutType.full);
        } catch (keycloakError) {
          debugPrint('Erreur Keycloak lors de la déconnexion: $keycloakError');
          // Continuer avec le nettoyage local même si Keycloak échoue
          await _cleanLocalData();
          return LogoutResult.error(
            'Déconnexion serveur échouée: $keycloakError', 
            LogoutType.localOnly
          );
        }
      } else {
        debugPrint('Pas de connexion réseau - déconnexion locale uniquement');
        await _cleanLocalData();
        return LogoutResult.success(LogoutType.localOnly);
      }
    } catch (e) {
      debugPrint('Erreur lors de la déconnexion: $e');
      await _cleanLocalData();
      return LogoutResult.error('Erreur de déconnexion: $e', LogoutType.localOnly);
    }
  }

  Future<void> _cleanLocalData() async {
    try {
      // Nettoyer le stockage sécurisé
      await _secureStorage.delete(key: 'access_token');
      await UserSessionManager.clearUserSession();
      
      // Réinitialiser les états internes
      _isRefreshing = false;
      _refreshCompleter = null;
      
      debugPrint('Nettoyage local terminé');
    } catch (e) {
      debugPrint('Erreur lors du nettoyage local: $e');
    }
  }

  void _cancelRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  Future<bool> _checkConnectivity() async {
    try {
      final connectivityResults = await Connectivity().checkConnectivity();
      // Vérifier si au moins une connexion est disponible
      return !connectivityResults.every((result) => result == ConnectivityResult.none);
    } catch (e) {
      debugPrint('Erreur lors de la vérification de connectivité: $e');
      // En cas d'erreur, assumer qu'il y a une connexion
      return true;
    }
  }

  // Méthode deprecated pour la rétrocompatibilité
  @Deprecated('Utiliser logout() qui retourne LogoutResult au lieu de bool')
  Future<bool> logoutLegacy() async {
    final result = await logout();
    return result.isSuccess;
  }

  Future<String?> getAccessToken() async {
    final storedToken = await _secureStorage.read(key: 'access_token');
    if (storedToken != null && storedToken.isNotEmpty) {
      return storedToken;
    }
    return _keycloak.accessToken;
  }

  String? getRefreshToken() => _keycloak.refreshToken;
  Future<Map<String, dynamic>?> getUserInfo() => _keycloak.getUserInfo();
  
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && await isTokenValid();
  }
}
