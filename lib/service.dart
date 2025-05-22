import 'dart:async';
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
       scheduleTokenRefresh(_keycloak.tokenResponse!.accessTokenExpirationDateTime?.millisecond ?? 1200 , _keycloak.refreshToken!);
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
  void scheduleTokenRefresh(int expiresInSeconds, String refreshToken) {
  final refreshDuration = Duration(seconds: expiresInSeconds - 60); // refresh 1 min before expiry

  Timer(refreshDuration, () async {
    try {
        await _keycloak.updateToken(refreshDuration);
      print('Token refreshed successfully');

      final newAccessToken = _keycloak.refreshToken;
      final newRefreshToken = _keycloak.refreshToken; // This might be updated by the wrapper
      
    //  if (newAccessToken != null && newAccessToken.isNotEmpty) 
        await UserSessionManager.updateTokens(
          newAccessToken: newAccessToken??'',
          newRefreshToken: newRefreshToken, // Pass along the new refresh token, if any
        );

      // Schedule the next refresh
       scheduleTokenRefresh(_keycloak.tokenResponse!.accessTokenExpirationDateTime?.millisecond ?? 1200 , _keycloak.refreshToken!);
    } catch (e) {
      print('Failed to refresh token: $e');
      // Possibly re-login or redirect to login page
    }
  });
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
    try {
      debugPrint('Attempting to refresh token using keycloak_wrapper.updateToken()...');
      // Attempt to update the token. The KeycloakWrapper should handle the refresh token internally.
      // The duration is how long the new token should be valid for, if the server supports it.
      // Keycloak's default is often shorter, but the wrapper might use this for its own expiry checks.
      await _keycloak.updateToken(const Duration(minutes: 50)); 
       
      debugPrint('Token refresh via updateToken completed ${_keycloak.accessToken} ${_keycloak.refreshToken}.');
      final newAccessToken = _keycloak.refreshToken;
      final newRefreshToken = _keycloak.refreshToken; // This might be updated by the wrapper

      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        await UserSessionManager.updateTokens(
          newAccessToken: newAccessToken,
          newRefreshToken: newRefreshToken, // Pass along the new refresh token, if any
        );
        debugPrint('Token refreshed and updated in UserSessionManager successfully.');
        return true;
      } else {
        debugPrint('Token refresh via updateToken seemed to succeed, but new access token is null or empty.');
        // This case might indicate an issue with the wrapper or Keycloak's response after updateToken.
        // Forcing a logout as it's an unexpected state post-refresh.
        await logout();
        return false;
      }
    } catch (e, s) { 
      debugPrint('Error during keycloak_wrapper.updateToken(): $e');
      debugPrint('Stack trace: $s');
      
      // Per the subtask's refined strategy: any failure in updateToken is treated as critical,
      // indicating the session may no longer be valid (e.g., refresh token expired or revoked).
      // Thus, proactively log out the user.
      debugPrint('Keycloak updateToken failed. Assuming critical session issue, logging out...');
      await logout();
      return false;
    }
  }
}
