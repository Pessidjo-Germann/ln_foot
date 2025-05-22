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
    final token = _keycloak.accessToken;
    final storedToken = await _secureStorage.read(key: 'access_token');

    return token ?? storedToken;
  }

  String? getRefreshToken() => _keycloak.refreshToken;
  Future<Map<String, dynamic>?> getUserInfo() => _keycloak.getUserInfo();
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  Future<bool> refreshToken() async {
    final refreshToken = getRefreshToken();
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse(
          'https://lnfoot-auth.hublots.co/realms/lnfoot/protocol/openid-connect/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'refresh_token',
        'client_id': 'ln-foot-01',
        'refresh_token': refreshToken,
        // 'client_secret': 'votre-secret-si-necessaire', // à ajouter si besoin
      },
    );

    if (response.statusCode == 200) {
      final nouveauxTokens = json.decode(response.body);
      final accessToken = nouveauxTokens['access_token'];
      final newRefreshToken = nouveauxTokens['refresh_token'];
      if (accessToken != null) {
        await _secureStorage.write(key: 'access_token', value: accessToken);
        // Si tu veux stocker le refresh token aussi :
        // await _secureStorage.write(key: 'refresh_token', value: newRefreshToken);
        return true;
      }
    }
    return false;
  }
}
