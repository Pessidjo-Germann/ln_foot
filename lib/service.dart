import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart'; // pour debugPrint

// service.dart
import 'package:keycloak_wrapper/keycloak_wrapper.dart';
import 'package:ln_foot/user_session_manager.dart';

class AuthService {
  final KeycloakWrapper _keycloak;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isRefreshing = false;
  // Un Completer qui sera utilisé pour permettre aux appels concurrents d'attendre
  // que le rafraîchissement en cours se termine et obtenir son résultat.
  // Il est initialisé à null ou à un Completer déjà complété pour ne pas bloquer au démarrage.
  Completer<bool>? _refreshCompleter;
  AuthService._(this._keycloak);

  static Future<AuthService> create() async {
    final wrapper = KeycloakWrapper(
      config: KeycloakConfig(
        bundleIdentifier: 'com.lnfoot',
        clientId: 'ln-foot-01',
        frontendUrl: 'https://lnfoot-auth.hublots.co',
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

      final expirationTime =
          _keycloak.tokenResponse!.accessTokenExpirationDateTime;
      if (expirationTime != null) {
        // Convertir le DateTime en secondes restantes
        final expiresInSeconds =
            expirationTime.difference(DateTime.now()).inSeconds;
        debugPrint("Expiration dans : $expiresInSeconds secondes");
        // S'assurer que le refresh token est disponible avant de planifier
        if (_keycloak.refreshToken != null) {
          scheduleTokenRefresh(expiresInSeconds, _keycloak.refreshToken!);
        } else {
          debugPrint("Erreur: Refresh token non disponible après login.");
        }
      } else {
        debugPrint("Erreur: Date d'expiration du token non disponible.");
      }

      if (userInfo != null) {
        await UserSessionManager.saveAuthenticatedUserData(
          accessToken: token!,
          refreshToken: _keycloak.refreshToken ?? '',
          userInfo: userInfo,
        );
      }

      if (token != null) {
        // Supprimer et réécrire le token pour s'assurer qu'il est à jour
        await _secureStorage.delete(key: 'access_token');
        await _secureStorage.write(key: 'access_token', value: token);
      }
    }
    return result;
  }

  void scheduleTokenRefresh(int expiresInSeconds, String refreshTokenValue) {
    // Rafraîchir 30 secondes avant l'expiration pour laisser une marge.
    // S'assurer que la durée est positive.
    final refreshDuration =
        Duration(seconds: (expiresInSeconds - 30).clamp(1, expiresInSeconds));

    debugPrint(
        'Planification du rafraîchissement du token dans $refreshDuration.');

    Timer(refreshDuration, () async {
      debugPrint(
          'Tentative de rafraîchissement du token via la tâche planifiée...');
      try {
        // Appelle la méthode refreshToken qui gère la concurrence
        final success = await refreshToken();
        if (success) {
          // Re-planifier si le refresh a réussi
          final newExpirationTime =
              _keycloak.tokenResponse!.accessTokenExpirationDateTime;
          if (newExpirationTime != null) {
            final newExpiresInSeconds =
                newExpirationTime.difference(DateTime.now()).inSeconds;
            if (newExpiresInSeconds > 0 && _keycloak.refreshToken != null) {
              scheduleTokenRefresh(
                  newExpiresInSeconds, _keycloak.refreshToken!);
            }
          }
        } else {
          debugPrint(
              'Le rafraîchissement du token planifié a échoué. Ne re-planifie pas.');
          // Gérer le cas où le rafraîchissement échoue (e.g., demander à l'utilisateur de se reconnecter)
        }
      } catch (e) {
        debugPrint('Erreur lors du rafraîchissement du token planifié: $e');
        // Gérer l'erreur (e.g., demander à l'utilisateur de se reconnecter)
      }
    });
  }

  Future<bool> logout() async {
    await _keycloak
        .logout(); // Décommenter si tu veux déconnecter de Keycloak aussi
    await _secureStorage.delete(key: 'access_token');
    await UserSessionManager.clearUserSession();
    _isRefreshing = false; // Réinitialiser le flag de rafraîchissement
    _refreshCompleter = null; // Réinitialiser le completer
    return true;
  }

  Future<String?> getAccessToken() async {
    final storedToken = await _secureStorage.read(key: 'access_token');
    // Prioriser le token stocké si disponible et valide, sinon celui de KeycloakWrapper.
    // Une vérification de validité pourrait être ajoutée ici si le token de KeycloakWrapper est déjà expiré.
    if (storedToken != null && storedToken.isNotEmpty) {
      return storedToken;
    }
    return _keycloak.accessToken;
  }

  String? getRefreshToken() => _keycloak.refreshToken;
  Future<Map<String, dynamic>?> getUserInfo() => _keycloak.getUserInfo();
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  Future<bool> refreshToken() async {
    if (_isRefreshing) {
      debugPrint(
          'AuthService: Une opération de rafraîchissement est déjà en cours. Attente du résultat...');
      // Attendre le résultat de l'opération en cours
      return _refreshCompleter!.future;
    }

    _isRefreshing = true;
    _refreshCompleter =
        Completer<bool>(); // Créer un nouveau completer pour cette opération

    try {
      debugPrint(
          'Tentative de rafraîchissement du token via keycloak_wrapper.updateToken()...');
      await _keycloak.updateToken(Duration(seconds: 300));

      debugPrint(
          'Rafraîchissement du token via updateToken terminé. Accès: ${_keycloak.accessToken?.substring(0, 10)}... Rafraîchissement: ${_keycloak.refreshToken?.substring(0, 10)}...');

      final newAccessToken = _keycloak.accessToken;
      final newRefreshToken = _keycloak.refreshToken;

      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        await UserSessionManager.updateTokens(
          newAccessToken: newAccessToken,
          newRefreshToken: newRefreshToken,
        );
        // Mettre à jour le token dans FlutterSecureStorage également
        await _secureStorage.delete(key: 'access_token');
        await _secureStorage.write(key: 'access_token', value: newAccessToken);

        debugPrint('Token rafraîchi et mis à jour avec succès.');
        _refreshCompleter!.complete(true); // Signaler que l'opération a réussi
        return true;
      } else {
        debugPrint(
            'Rafraîchissement du token a réussi, mais le nouveau token d\'accès est nul ou vide. Déconnexion forcée.');
        await logout();
        _refreshCompleter!.complete(false); // Signaler l'échec
        return false;
      }
    } catch (e, s) {
      debugPrint(
          'Erreur lors du rafraîchissement du token via keycloak_wrapper.updateToken(): $e');
      debugPrint('Trace de la pile: $s');

      debugPrint(
          'Échec du rafraîchissement de Keycloak. Problème critique de session, déconnexion...');
      await logout();
      _refreshCompleter!.complete(false); // Signaler l'échec
      return false;
    } finally {
      _isRefreshing =
          false; // Réinitialiser le flag une fois l'opération terminée (réussie ou échouée)
    }
  }
}
