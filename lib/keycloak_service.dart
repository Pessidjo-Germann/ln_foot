import 'package:keycloak_wrapper/keycloak_wrapper.dart';

class KeycloakService {
  final KeycloakWrapper _keycloak;

  KeycloakService()
      : _keycloak = KeycloakWrapper(
          config: KeycloakConfig(
            bundleIdentifier: 'com.lnfoot://callback',
            clientId: 'ln-foot-01',
            frontendUrl: 'https://lnfoot-auth.hublots.co/auth',
            realm: 'lnfoot',
          ),
        ) {
    _keycloak.initialize();
  }

  Stream<bool> get authStream => _keycloak.authenticationStream;

  Future<bool> login() => _keycloak.login();

  Future<bool> logout() => _keycloak.logout();
   

  Future<Map<String, dynamic>?> getUserInfo() => _keycloak.getUserInfo();
}
