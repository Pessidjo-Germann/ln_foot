import 'package:openid_client/openid_client_io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart'; // pour debugPrint
import 'package:url_launcher/url_launcher.dart';

// service.dart
import 'package:keycloak_wrapper/keycloak_wrapper.dart';

class AuthService {
  final KeycloakWrapper _keycloak;

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
  Future<bool> login() => _keycloak.login();
  Future<bool> logout() => _keycloak.logout();
  Future<Map<String, dynamic>?> getUserInfo() => _keycloak.getUserInfo();
}


// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';

// class AuthService {
//   final FlutterAppAuth _appAuth = FlutterAppAuth();
//   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

//   final String clientId = 'ln-foot-01';
//   final String redirectUrl = 'com.lnfoot://callback';
//   final List<String> scopes = ['openid', 'profile', 'email'];

//   final AuthorizationServiceConfiguration _serviceConfiguration =
//       AuthorizationServiceConfiguration(
//     authorizationEndpoint:
//         'https://lnfoot-auth.hublots.co/realms/lnfoot/protocol/openid-connect/auth',
//     tokenEndpoint:
//         'https://lnfoot-auth.hublots.co/realms/lnfoot/protocol/openid-connect/token',
//   );

//   Future<String> loginWithKeycloak() async {
//     final result = await _appAuth.authorizeAndExchangeCode(
//       AuthorizationTokenRequest(
//         clientId,
//         redirectUrl,
//         serviceConfiguration: _serviceConfiguration,
//         scopes: scopes,
//         promptValues: ['login'],
//       ),
//     );

//     if (result == null || result.accessToken == null) {
//       throw Exception("Échec de l'authentification");
//     }

//     await _secureStorage.write(key: 'access_token', value: result.accessToken);
//     await _secureStorage.write(
//         key: 'refresh_token', value: result.refreshToken);

//     return result.accessToken!;
//   }

//   Future<void> logout() async {
//     await _secureStorage.deleteAll();
//   }

//   Future<bool> isLoggedIn() async {
//     final token = await _secureStorage.read(key: 'access_token');
//     return token != null;
//   }
// }
/**
 * 
 * import 'package:openid_client/openid_client_io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

final storage = FlutterSecureStorage();

Future<void> login() async {
  var issuer = await Issuer.discover(Uri.parse('http://localhost:8080/realms/myrealm'));
  var client = Client(issuer, 'myapp-client');

  var authenticator = Authenticator(
    client,
    scopes: ['openid', 'profile', 'email', 'offline_access'],
    port: 4000,
    redirectUri: Uri.parse('com.example.myapp:/callback'),
  );

  var c = await authenticator.authorize();

  var tokenResponse = await c.getTokenResponse();

  await storage.write(key: 'access_token', value: tokenResponse.accessToken);
  await storage.write(key: 'refresh_token', value: tokenResponse.refreshToken);

  // Fermer la session d'authentification
  closeWebView();
}

 */