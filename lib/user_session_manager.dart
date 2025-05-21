import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSessionManager {
  static final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();

  static Future<void> saveAuthenticatedUserData({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> userInfo,
  }) async {
    try {
      await _secureStorage.write(key: 'access_token', value: accessToken);
      await _secureStorage.write(key: 'refresh_token', value: refreshToken);
      // Encoder en JSON avant de stocker
      await _secureStorage.write(key: 'user_info', value: jsonEncode(userInfo));

      final now = DateTime.now();
      final expiresAt = now.add(const Duration(minutes: 15));
      await _secureStorage.write(
          key: 'token_expires_at', value: expiresAt.toIso8601String());
    } catch (e) {
      print("Erreur lors de l'enregistrement de la session utilisateur : $e");
    }
  }

  static Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final userJson = await _secureStorage.read(key: 'user_info');
      if (userJson != null) {
        return jsonDecode(userJson) as Map<String, dynamic>;
      }
    } catch (e) {
      print("Erreur lors de la récupération des infos utilisateur : $e");
    }
    return null;
  }

  static Future<void> clearUserSession() async {
    await _secureStorage.deleteAll();
  }
}
