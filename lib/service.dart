import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class AuthService {
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  final String clientId = 'ln-foot-01';
  final String redirectUrl = 'com.lnfoot://callback';
  final List<String> scopes = ['openid', 'profile', 'email'];

  final AuthorizationServiceConfiguration _serviceConfiguration =
      AuthorizationServiceConfiguration(
    authorizationEndpoint:
        'https://lnfoot-auth.hublots.co/realms/lnfoot/protocol/openid-connect/auth',
    tokenEndpoint:
        'https://lnfoot-auth.hublots.co/realms/lnfoot/protocol/openid-connect/token',
  );

  Future<String> loginWithKeycloak() async {
    final result = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        serviceConfiguration: _serviceConfiguration,
        scopes: scopes,
        promptValues: ['login'],
      ),
    );

    if (result == null || result.accessToken == null) {
      throw Exception("Échec de l'authentification");
    }

    await _secureStorage.write(key: 'access_token', value: result.accessToken);
    await _secureStorage.write(
        key: 'refresh_token', value: result.refreshToken);

    return result.accessToken!;
  }

  Future<void> logout() async {
    await _secureStorage.deleteAll();
  }

  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null;
  }
}
