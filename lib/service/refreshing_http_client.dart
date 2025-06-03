import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ln_foot/service.dart';

class RefreshingHttpClient extends http.BaseClient {
  final http.Client _inner;
  final AuthService authService;
  static const int _maxRetries = 1;

  RefreshingHttpClient(this._inner, this.authService);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    debugPrint('RefreshingHttpClient: ${request.method} ${request.url}');

    // AMÉLIORATION: Utiliser refreshTokenIfNeeded au lieu de vérifie manuellement
    await authService.refreshTokenIfNeeded();
    
    final String? token = await authService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
      debugPrint('RefreshingHttpClient: Token ajouté');
    } else {
      debugPrint('RefreshingHttpClient: Pas de token disponible');
    }

    http.StreamedResponse response;
    try {
      response = await _inner.send(request);
      debugPrint('RefreshingHttpClient: Status ${response.statusCode}');
    } catch (e) {
      debugPrint('RefreshingHttpClient: Erreur réseau: $e');
      rethrow;
    }
    
    // AMÉLIORATION: Gestion plus robuste du 401
    if (response.statusCode == 401) {
      debugPrint('RefreshingHttpClient: 401 détecté, tentative de refresh...');
      
      try {
        // Force le refresh (pas refreshTokenIfNeeded car on a déjà un 401)
        final refreshed = await authService.refreshToken();
        
        if (refreshed) {
          final String? newToken = await authService.getAccessToken();
          if (newToken != null && newToken.isNotEmpty) {
            debugPrint('RefreshingHttpClient: Retry avec nouveau token');
            
            // Créer une nouvelle requête avec le nouveau token
            final newRequest = _copyRequest(request);
            newRequest.headers['Authorization'] = 'Bearer $newToken';
            
            // Libérer les ressources de la réponse 401
            await response.stream.drain();
            
            // Retry la requête
            response = await _inner.send(newRequest);
            debugPrint('RefreshingHttpClient: Retry status ${response.statusCode}');
          }
        } else {
          debugPrint('RefreshingHttpClient: Refresh échoué, retour 401');
        }
      } catch (e) {
        debugPrint('RefreshingHttpClient: Erreur durant refresh: $e');
        // Retourner la réponse 401 originale si le refresh échoue
      }
    }
    
    return response;
  }

  // AMÉLIORATION: Méthode helper pour copier une requête
  http.BaseRequest _copyRequest(http.BaseRequest original) {
    if (original is http.Request) {
      final newRequest = http.Request(original.method, original.url);
      newRequest.headers.addAll(original.headers);
      newRequest.body = original.body;
      return newRequest;
    } else if (original is http.MultipartRequest) {
      final newRequest = http.MultipartRequest(original.method, original.url);
      newRequest.headers.addAll(original.headers);
      newRequest.fields.addAll(original.fields);
      newRequest.files.addAll(original.files);
      return newRequest;
    } else {
      // Pour les autres types, on retourne l'original
      // Dans un cas réel, vous pourriez vouloir gérer plus de types
      return original;
    }
  }

  @override
  void close() {
    debugPrint('RefreshingHttpClient: Fermeture');
    _inner.close();
  }
}
