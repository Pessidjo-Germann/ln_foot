import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart'; // pour debugPrint
import 'package:http/http.dart' as http;
import 'dart:convert';

// service.dart
import 'package:keycloak_wrapper/keycloak_wrapper.dart';
import 'package:ln_foot/user_session_manager.dart';

class AuthService {
  final KeycloakWrapper _keycloak;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

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
      // Enregistrement du token dans le stockage sécurisé
      final userInfo = await _keycloak.getUserInfo();
      debugPrint("les INDOE D SSD  sont : $userInfo");
      if (userInfo != null) {
        await UserSessionManager.saveAuthenticatedUserData(
          accessToken: token!,
          refreshToken: _keycloak.refreshToken ?? '',
          userInfo: userInfo,
        );
      }

      if (token != null) {
        await _secureStorage.delete(key: 'access_token');
        await _secureStorage.write(key: 'access_token', value: token);
      }
    }
    return result;
  }

  Future<bool> logout() async {
    // final result = await _keycloak.logout();
    await _secureStorage.delete(key: 'access_token');
    await UserSessionManager.clearUserSession();
    return true;
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
    final token = await _secureStorage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  Future<bool> refreshToken() async {
    final String? oldRefreshToken = await UserSessionManager.getRefreshToken();
    if (oldRefreshToken == null) {
      debugPrint("No refresh token found in session manager.");
      return false;
    }

    final response = await http.post(
      Uri.parse(
          '${_keycloak.config.frontendUrl}/realms/${_keycloak.config.realm}/protocol/openid-connect/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'refresh_token',
        'client_id': _keycloak.config.clientId,
        'refresh_token': oldRefreshToken,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> nouveauxTokens = json.decode(response.body);
      final String? newAccessToken = nouveauxTokens['access_token'] as String?;
      final String? newRefreshToken =
          nouveauxTokens['refresh_token'] as String?;

      if (newAccessToken != null) {
        try {
          await UserSessionManager.updateTokens(
            newAccessToken: newAccessToken,
            newRefreshToken: newRefreshToken, // Pass null if not present, UserSessionManager handles it
          );
          debugPrint("Tokens updated successfully via UserSessionManager.");
          return true;
        } catch (e) {
          debugPrint("Error updating tokens via UserSessionManager: $e");
          return false;
        }
      } else {
        debugPrint("New access token is null in Keycloak response.");
        return false;
      }
    } else {
      debugPrint(
          "Failed to refresh token. Status code: ${response.statusCode}, Body: ${response.body}");
      try {
        final Map<String, dynamic> decodedBody = json.decode(response.body);
        if (decodedBody.containsKey('error') && decodedBody['error'] == 'invalid_grant') {
          debugPrint("Refresh token failed due to 'invalid_grant'. User is being logged out.");
          await logout();
        }
      } catch (e) {
        // If response body is not valid JSON or not a map, just log the original error.
        debugPrint("Error parsing Keycloak error response or unexpected format: $e");
      }
      return false;
    }
  }
}
