# 🚀 Guide de Déploiement - LN FOOT Shop

## 📋 Prérequis

### Environnement de Développement
- **Flutter SDK** : 3.x ou supérieur
- **Dart SDK** : 3.x ou supérieur
- **Android Studio** / **VS Code** avec extensions Flutter
- **Xcode** (pour iOS, macOS uniquement)

### Services Externes
- **Serveur Keycloak** configuré et accessible
- **API Backend** déployée et fonctionnelle
- **Certificats** pour signature d'applications

## 🏗️ Configuration Pré-Déploiement

### 1. Configuration Keycloak

#### Création du Client Keycloak
```json
{
  "clientId": "ln-foot-01",
  "name": "LN FOOT Mobile App",
  "protocol": "openid-connect",
  "publicClient": true,
  "standardFlowEnabled": true,
  "directAccessGrantsEnabled": false,
  "serviceAccountsEnabled": false,
  "authorizationServicesEnabled": false,
  "redirectUris": [
    "com.lnfoot://oauth/redirect/*",
    "http://localhost:8080/*"
  ],
  "webOrigins": ["+"]
}
```

#### Configuration des Scopes
- `openid` (obligatoire)
- `profile` (informations utilisateur)
- `email` (adresse email)
- `offline_access` (refresh tokens)

### 2. Configuration Flutter

#### pubspec.yaml - Dépendances Critiques
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  keycloak_wrapper: ^2.0.0
  flutter_secure_storage: ^9.0.0
  http: ^1.1.0
  connectivity_plus: ^5.0.0
  shared_preferences: ^2.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.7
```

#### Configuration Android (android/app/build.gradle)
```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.lnfoot"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

#### Configuration iOS (ios/Runner/Info.plist)
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.lnfoot.oauth</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.lnfoot</string>
        </array>
    </dict>
</array>
```

### 3. Variables d'Environnement

#### Configuration de Production
```dart
// lib/config/app_config.dart
class AppConfig {
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'production'
  );
  
  static const String keycloakUrl = String.fromEnvironment(
    'KEYCLOAK_URL',
    defaultValue: 'https://auth.ln-foot.com'
  );
  
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL', 
    defaultValue: 'https://api.ln-foot.com'
  );
  
  static const String keycloakClientId = String.fromEnvironment(
    'KEYCLOAK_CLIENT_ID',
    defaultValue: 'ln-foot-01'
  );
  
  static const String keycloakRealm = String.fromEnvironment(
    'KEYCLOAK_REALM',
    defaultValue: 'lnfoot'
  );
}
```

## 📱 Builds de Production

### Android

#### 1. Génération du Keystore
```powershell
keytool -genkey -v -keystore d:\flutter_projects\ln_foot\android\app\upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

#### 2. Configuration Signature (android/key.properties)
```properties
storePassword=your_store_password
keyPassword=your_key_password  
keyAlias=upload
storeFile=upload-keystore.jks
```

#### 3. Build Release
```powershell
# Build APK
flutter build apk --release --dart-define=ENV=production

# Build App Bundle (recommandé pour Play Store)
flutter build appbundle --release --dart-define=ENV=production
```

### iOS

#### 1. Configuration des Certificates
- Certificat de distribution iOS
- Provisioning Profile de distribution
- Configuration dans Xcode

#### 2. Build Release
```powershell
flutter build ios --release --dart-define=ENV=production
```

#### 3. Archive via Xcode
1. Ouvrir `ios/Runner.xcworkspace` dans Xcode
2. Product → Archive
3. Distribute App → App Store Connect

### Web

#### Build Web
```powershell
flutter build web --release --dart-define=ENV=production
```

## 🚀 Processus de Déploiement

### 1. Tests Pré-Déploiement

#### Tests Automatisés
```powershell
# Tests unitaires
flutter test

# Tests d'intégration 
flutter drive --target=test_driver/app.dart

# Analyse statique
flutter analyze
```

#### Tests Manuels Critiques
- [ ] Authentification Keycloak
- [ ] Refresh automatique des tokens
- [ ] Navigation offline/online
- [ ] Gestion du panier
- [ ] Processus de commande

### 2. Validation Environnements

#### Environnement de Staging
```powershell
flutter build apk --release --dart-define=ENV=staging --dart-define=KEYCLOAK_URL=https://auth-staging.ln-foot.com
```

#### Environnement de Production
```powershell
flutter build apk --release --dart-define=ENV=production --dart-define=KEYCLOAK_URL=https://auth.ln-foot.com
```

### 3. Déploiement Stores

#### Google Play Store
1. **Préparation**
   - App Bundle signé
   - Screenshots (téléphone, tablette)
   - Description de l'app
   - Politique de confidentialité

2. **Upload**
   - Google Play Console
   - Release interne → Release fermée → Release ouverte

3. **Review Process**
   - Délai : 1-3 jours
   - Réponse aux questions du review

#### Apple App Store
1. **Préparation**
   - Archive via Xcode
   - Screenshots (tous les devices)
   - Métadonnées de l'app

2. **App Store Connect**
   - Upload de l'archive
   - Configuration des métadonnées
   - Soumission pour review

3. **Review Process**
   - Délai : 1-7 jours
   - Suivi via App Store Connect

## 🔧 Configuration Serveur

### Backend API

#### Prérequis
- CORS configuré pour l'app mobile
- HTTPS activé
- Rate limiting approprié
- Logs d'audit

#### Configuration CORS
```yaml
# Exemple Spring Boot
cors:
  allowed-origins: 
    - "https://ln-foot.com"
    - "capacitor://localhost"
    - "http://localhost"
  allowed-methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
  allowed-headers: ["*"]
  allow-credentials: true
```

### Keycloak

#### Configuration Production
```json
{
  "realm": "lnfoot",
  "ssl-required": "external",
  "login-theme": "lnfoot-custom",
  "default-locale": "fr",
  "internationalization-enabled": true,
  "supported-locales": ["fr", "en"],
  "access-token-lifespan": 300,
  "access-token-lifespan-for-implicit-flow": 900,
  "sso-session-idle-timeout": 1800,
  "sso-session-max-lifespan": 36000,
  "offline-session-idle-timeout": 2592000
}
```

#### Clients Configuration
- **Mobile App** : Public client, PKCE activé
- **Backend API** : Confidential client pour validation tokens

## 📊 Monitoring Post-Déploiement

### Métriques Critiques

#### Application
- Taux de crashes
- Temps de démarrage
- Erreurs d'authentification
- Performance des requêtes API

#### Authentification
- Taux de réussite login
- Fréquence des refresh tokens
- Erreurs 401/403
- Sessions expirées

#### Business
- Taux de conversion
- Utilisation des fonctionnalités
- Abandon de panier
- Temps passé dans l'app

### Outils de Monitoring

#### Firebase Analytics/Crashlytics
```dart
// Configuration dans main.dart
await Firebase.initializeApp();
FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
```

#### Logs Centralisés
```dart
// Service de logging
class LoggingService {
  static void logError(String message, dynamic error, StackTrace? stackTrace) {
    debugPrint('ERROR: $message');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
  
  static void logEvent(String eventName, Map<String, dynamic> parameters) {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
```

## 🔄 Processus de Mise à Jour

### Updates Over-The-Air (OTA)

#### Code Push (optionnel)
- Mise à jour du code Dart sans republication
- Idéal pour les corrections mineures
- Attention : ne fonctionne pas avec les changements natifs

### Versioning Strategy

#### Version Numbers
```yaml
# pubspec.yaml
version: 1.2.3+4
# 1.2.3 = version utilisateur (major.minor.patch)
# 4 = build number (incrémental)
```

#### Release Notes
```markdown
## Version 1.2.0
### Nouvelles Fonctionnalités
- Ajout du système de notifications push
- Amélioration de la recherche de produits

### Corrections
- Correction du bug de synchronisation du panier
- Amélioration de la stabilité de l'authentification
```

## 🛡️ Sécurité en Production

### Checklist Sécurité

#### Application
- [ ] Obfuscation du code activée
- [ ] Debug prints supprimés en production
- [ ] API keys sécurisées (pas dans le code)
- [ ] Validation des certificats SSL

#### Authentification
- [ ] Tokens stockés de façon sécurisée
- [ ] Refresh automatique configuré
- [ ] Déconnexion automatique en cas d'erreur
- [ ] PKCE activé pour OAuth

#### Communication
- [ ] HTTPS uniquement
- [ ] Certificate pinning (optionnel)
- [ ] Timeout appropriés
- [ ] Retry logic sécurisée

## 📋 Rollback Plan

### En Cas de Problème Critique

#### Actions Immédiates
1. **Arrêt du rollout** dans les stores
2. **Communication** aux utilisateurs
3. **Investigation** des logs d'erreur
4. **Hotfix** si possible

#### Rollback Process
```powershell
# Revenir à la version précédente
git checkout tags/v1.1.9
flutter build appbundle --release --dart-define=ENV=production

# Upload emergency release
# Augmenter le version code/build number
```

#### Communication Crisis
- Status page mise à jour
- Notification aux utilisateurs actifs
- Email aux clients critiques
- Mise à jour des stores

---

*Guide de déploiement mis à jour le 3 juin 2025 - Version 1.0*
