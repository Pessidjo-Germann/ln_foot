# 📊 Analyse UML - LN FOOT Shop

## 🎯 Vue d'Ensemble du Projet

**LN FOOT** est une application mobile e-commerce développée en Flutter pour la vente d'équipements sportifs. L'application utilise une architecture moderne basée sur le pattern BLoC pour la gestion d'état et intègre Keycloak pour l'authentification.

### Fonctionnalités Principales
- 🔐 Système d'authentification complet (login, signup, mot de passe oublié, OTP)
- 🛍️ Catalogue de produits avec catégories et recherche
- 🛒 Panier d'achat et système de commande
- ⭐ Système de reviews et d'évaluations
- 👤 Gestion de profil utilisateur
- 💾 Sauvegarde d'articles favoris
- 🌐 Gestion de l'état réseau (online/offline)

---

## 📋 1. Diagrammes de Cas d'Usage (Use Cases)

### 1.1 Acteurs du Système

```mermaid
graph TB
    Guest[Visiteur Non Connecté]
    User[Utilisateur Connecté]
    Admin[Administrateur]
    Keycloak[Système Keycloak]
    PaymentGateway[Passerelle de Paiement]
```

### 1.2 Cas d'Usage - Authentification

```plantuml
@startuml
left to right direction
skinparam packageStyle rectangle

actor "Utilisateur" as User
actor "Système Keycloak" as Keycloak

rectangle "Authentification" {
  usecase "S'inscrire" as UC1
  usecase "Se connecter" as UC2
  usecase "Mot de passe oublié" as UC3
  usecase "Vérification OTP" as UC4
  usecase "Réinitialiser mot de passe" as UC5
  usecase "Se déconnecter" as UC6
  usecase "Rafraîchir token" as UC7
}

User --> UC1
User --> UC2
User --> UC3
User --> UC4
User --> UC5
User --> UC6

UC1 --> Keycloak
UC2 --> Keycloak
UC3 --> Keycloak
UC4 --> Keycloak
UC5 --> Keycloak
UC6 --> Keycloak
UC7 --> Keycloak

UC3 .> UC4 : include
UC4 .> UC5 : include
UC2 .> UC7 : extend
@enduml
```

### 1.3 Cas d'Usage - E-Commerce

```plantuml
@startuml
left to right direction
skinparam packageStyle rectangle

actor "Visiteur" as Guest
actor "Utilisateur" as User
actor "Système API" as API

rectangle "Catalogue Produits" {
  usecase "Consulter produits" as UC1
  usecase "Rechercher produits" as UC2
  usecase "Filtrer par catégorie" as UC3
  usecase "Voir détails produit" as UC4
  usecase "Consulter reviews" as UC5
}

rectangle "Panier & Commandes" {
  usecase "Ajouter au panier" as UC6
  usecase "Modifier quantité" as UC7
  usecase "Supprimer du panier" as UC8
  usecase "Passer commande" as UC9
  usecase "Voir mes commandes" as UC10
  usecase "Suivre commande" as UC11
}

rectangle "Gestion Utilisateur" {
  usecase "Gérer profil" as UC12
  usecase "Sauvegarder favoris" as UC13
  usecase "Écrire review" as UC14
  usecase "Noter produit" as UC15
}

Guest --> UC1
Guest --> UC2
Guest --> UC3
Guest --> UC4
Guest --> UC5

User --> UC1
User --> UC2
User --> UC3
User --> UC4
User --> UC5
User --> UC6
User --> UC7
User --> UC8
User --> UC9
User --> UC10
User --> UC11
User --> UC12
User --> UC13
User --> UC14
User --> UC15

UC1 --> API
UC2 --> API
UC3 --> API
UC4 --> API
UC5 --> API
UC6 --> API
UC9 --> API
UC10 --> API
UC14 --> API
UC15 --> API

UC6 .> UC4 : include
UC9 .> UC6 : include
UC14 .> UC4 : include
UC15 .> UC4 : include
@enduml
```

---

## 🔄 2. Diagrammes de Séquence

### 2.1 Séquence d'Authentification OAuth

```plantuml
@startuml
participant "User" as U
participant "Flutter App" as App
participant "AuthBloc" as AB
participant "AuthService" as AS
participant "Keycloak" as KC
participant "API Client" as API

U -> App: Démarrer l'app
App -> AB: AppStarted()
AB -> AS: isTokenValid()
AS -> AS: Vérifier token local
alt Token valide
    AS -> AB: return true
    AB -> AS: getUserInfo()
    AS -> API: Requête avec token
    API -> AB: UserInfo
    AB -> App: Authenticated(user)
    App -> U: Afficher HomeScreen
else Token invalide
    AS -> AB: return false
    AB -> AS: refreshTokenIfNeeded()
    AS -> KC: POST /token (refresh)
    alt Refresh réussi
        KC -> AS: nouveaux tokens
        AS -> AB: return true
        AB -> App: Authenticated(user)
        App -> U: Afficher HomeScreen
    else Refresh échoué
        KC -> AS: error
        AS -> AB: return false
        AB -> App: Unauthenticated()
        App -> U: Afficher LoginScreen
    end
end

U -> App: Clic "Se connecter"
App -> AB: LoginRequested()
AB -> AS: login()
AS -> KC: OAuth flow
KC -> AS: authorization_code
AS -> KC: POST /token
KC -> AS: access_token + refresh_token
AS -> AS: Sauvegarder tokens
AS -> AB: success
AB -> App: Authenticated(user)
App -> U: Afficher HomeScreen
@enduml
```

### 2.2 Séquence d'Ajout au Panier

```plantuml
@startuml
participant "User" as U
participant "ProductDetailsScreen" as PDS
participant "CartBloc" as CB
participant "SharedPreferences" as SP
participant "ProductBloc" as PB

U -> PDS: Sélectionner taille/couleur
PDS -> PDS: _selectedSize = size
U -> PDS: Clic "Ajouter au panier"
PDS -> CB: AddToCart(product, size, color, quantity)

CB -> CB: _cartItems.add(cartItem)
CB -> SP: saveCartItems(cartItems)
SP -> CB: success
CB -> PDS: CartUpdated(items, total)
PDS -> U: Afficher message succès

U -> PDS: Naviguer vers panier
PDS -> U: CartScreen
note right: L'utilisateur peut maintenant\nvoir ses articles dans le panier
@enduml
```

### 2.3 Séquence de Commande

```plantuml
@startuml
participant "User" as U
participant "CartScreen" as CS
participant "CheckoutScreen" as COS
participant "OrderBloc" as OB
participant "OrderAPI" as API
participant "PaymentGateway" as PG

U -> CS: Clic "Commander"
CS -> COS: Naviguer
COS -> U: Afficher formulaire

U -> COS: Remplir infos livraison
U -> COS: Sélectionner paiement
U -> COS: Confirmer commande

COS -> OB: CreateOrder(orderDetails)
OB -> API: POST /orders
API -> OB: Order created (pending)
OB -> COS: OrderCreating()

COS -> PG: Initier paiement
PG -> COS: Payment result
alt Paiement réussi
    COS -> OB: ConfirmPayment(orderId)
    OB -> API: PUT /orders/{id}/confirm
    API -> OB: Order confirmed
    OB -> COS: OrderCompleted()
    COS -> U: Afficher succès
else Paiement échoué
    COS -> OB: CancelOrder(orderId)
    OB -> API: PUT /orders/{id}/cancel
    API -> OB: Order cancelled
    OB -> COS: OrderCancelled()
    COS -> U: Afficher erreur
end
@enduml
```

---

## 📊 3. Diagrammes d'Activité

### 3.1 Processus d'Authentification

```plantuml
@startuml
start
:Démarrage de l'application;
:Vérifier token stocké;

if (Token valide?) then (oui)
  :Récupérer infos utilisateur;
  :Afficher écran principal;
  stop
else (non)
  if (Refresh token disponible?) then (oui)
    :Tenter refresh token;
    if (Refresh réussi?) then (oui)
      :Sauvegarder nouveaux tokens;
      :Afficher écran principal;
      stop
    else (non)
      :Supprimer tokens invalides;
    endif
  endif
  :Afficher écran de connexion;
  :Utilisateur saisit identifiants;
  :Lancer processus OAuth;
  if (Authentification réussie?) then (oui)
    :Sauvegarder tokens;
    :Afficher écran principal;
  else (non)
    :Afficher message d'erreur;
    :Retour écran connexion;
  endif
endif
stop
@enduml
```

### 3.2 Processus d'Achat

```plantuml
@startuml
start
:Consulter catalogue;
:Sélectionner un produit;
:Voir détails produit;

if (Produit souhaité?) then (oui)
  :Sélectionner taille;
  :Sélectionner couleur;
  :Choisir quantité;
  :Ajouter au panier;
  
  if (Continuer shopping?) then (oui)
    :Retour catalogue;
  else (non)
    :Aller au panier;
    :Vérifier articles;
    
    if (Modifier panier?) then (oui)
      :Modifier quantités;
      :Supprimer articles;
    endif
    
    :Procéder au checkout;
    :Saisir adresse livraison;
    :Choisir mode de paiement;
    :Confirmer commande;
    
    if (Paiement réussi?) then (oui)
      :Vider panier;
      :Envoyer confirmation;
      :Afficher numéro commande;
      stop
    else (non)
      :Afficher erreur paiement;
      :Retour au panier;
    endif
  endif
else (non)
  :Continuer navigation;
endif
stop
@enduml
```

### 3.3 Gestion des Reviews

```plantuml
@startuml
start
:Accéder détails produit;
:Consulter reviews existantes;

if (Utilisateur connecté?) then (oui)
  if (A acheté le produit?) then (oui)
    if (Souhaite écrire review?) then (oui)
      :Sélectionner note (1-5);
      :Rédiger commentaire;
      :Soumettre review;
      
      if (Review valide?) then (oui)
        :Sauvegarder review;
        :Mettre à jour moyenne;
        :Afficher confirmation;
        :Actualiser liste reviews;
      else (non)
        :Afficher erreurs validation;
      endif
    endif
  else (non)
    :Masquer option review;
  endif
else (non)
  :Afficher "Connectez-vous pour écrire une review";
endif

stop
@enduml
```

---

## 🏗️ 4. Diagrammes de Classes

### 4.1 Architecture BLoC - Gestion d'État

```plantuml
@startuml
package "BLoC Architecture" {
  abstract class Bloc<Event, State> {
    +Stream<State> stream
    +State state
    +add(Event event)
    +emit(State state)
  }
  
  abstract class BlocEvent {
  }
  
  abstract class BlocState {
  }
  
  class AuthBloc extends Bloc {
    -AuthService authService
    +AuthBloc(authService)
    -_onAppStarted()
    -_onLoginRequested()
    -_onLogoutRequested()
    -_onCheckToken()
  }
  
  class AuthEvent extends BlocEvent {
  }
  
  class AuthState extends BlocState {
  }
  
  class AppStarted extends AuthEvent
  class LoginRequested extends AuthEvent
  class LogoutRequested extends AuthEvent
  class CheckToken extends AuthEvent
  
  class AuthInitial extends AuthState
  class AuthLoading extends AuthState
  class Authenticated extends AuthState {
    +UserInfo user
  }
  class Unauthenticated extends AuthState
  class AuthError extends AuthState {
    +String message
  }
}

AuthBloc --> AuthService
AuthBloc --> AuthEvent
AuthBloc --> AuthState
@enduml
```

### 4.2 Entités Métier Principales

```plantuml
@startuml
package "Core Entities" {
  class ProductDto {
    +String? id
    +String? name
    +String? description
    +num price
    +List<String> imageUrls
    +List<String> categoryNames
    +double? averageRating
    +int? reviewCount
    +bool? isAvailable
    +DateTime? createdAt
    +DateTime? updatedAt
  }
  
  class ProductVariantDto {
    +String? id
    +String? productId
    +String? size
    +String? color
    +int? stockQuantity
    +num? additionalPrice
  }
  
  class CategoryDto {
    +String? id
    +String? name
    +String? description
    +String? imageUrl
    +List<ProductDto>? products
  }
  
  class CartItem {
    +ProductDto product
    +String size
    +String color
    +int quantity
    +double total
    +copyWith()
    +toJson()
    +fromJson()
  }
  
  class OrderDto {
    +String? id
    +String? userId
    +List<OrderItemDto> items
    +num totalAmount
    +OrderStatus status
    +String? shippingAddress
    +String? paymentMethod
    +DateTime? createdAt
    +DateTime? updatedAt
  }
  
  class OrderItemDto {
    +String? productId
    +String? productName
    +String size
    +String color
    +int quantity
    +num unitPrice
    +num totalPrice
  }
  
  class ReviewDto {
    +String? id
    +String? productId
    +String? userId
    +String? userName
    +int rating
    +String? comment
    +DateTime? createdAt
  }
  
  class UserInfo {
    +String? id
    +String? username
    +String? email
    +String? firstName
    +String? lastName
    +List<String>? roles
  }
  
  enum OrderStatus {
    PENDING
    CONFIRMED
    PROCESSING
    SHIPPED
    DELIVERED
    CANCELLED
  }
}

ProductDto ||--o{ ProductVariantDto : has variants
CategoryDto ||--o{ ProductDto : contains
CartItem ||--|| ProductDto : references
OrderDto ||--o{ OrderItemDto : contains
ReviewDto }o--|| ProductDto : reviews
OrderDto }o--|| UserInfo : placed by
ReviewDto }o--|| UserInfo : written by
OrderDto ||--|| OrderStatus : has status
@enduml
```

### 4.3 Architecture des Services

```plantuml
@startuml
package "Services Layer" {
  interface AuthService {
    +login()
    +logout()
    +getAccessToken()
    +getRefreshToken()
    +refreshTokenIfNeeded()
    +isTokenValid()
    +getUserInfo()
    +Stream<bool> authStream
  }
  
  class KeycloakAuthService implements AuthService {
    -OpenIdConnect openIdConnect
    -SharedPreferences prefs
    -String clientId
    -String redirectUri
    +create()
    +_saveTokens()
    +_loadTokens()
    +_clearTokens()
  }
  
  class RefreshingHttpClient {
    -http.Client baseClient
    -AuthService authService
    +send(request)
    -_refreshTokenAndRetry()
  }
  
  class ApiClient {
    +http.Client client
    +String basePath
    +ApiKeyAuth authentication
  }
  
  abstract class ControllerApi {
    +ApiClient apiClient
  }
  
  class ProductControllerApi extends ControllerApi {
    +getAllProducts()
    +getProductById(id)
    +createProduct(product)
    +updateProduct(id, product)
    +deleteProduct(id)
  }
  
  class OrderControllerApi extends ControllerApi {
    +createOrder(order)
    +getOrderById(id)
    +getUserOrders(userId)
    +updateOrderStatus(id, status)
  }
  
  class CategoryControllerApi extends ControllerApi {
    +getAllCategories()
    +getCategoryById(id)
    +getProductsByCategory(categoryId)
  }
  
  class ReviewControllerApi extends ControllerApi {
    +getProductReviews(productId)
    +createReview(review)
    +updateReview(id, review)
    +deleteReview(id)
  }
}

RefreshingHttpClient --> AuthService
ApiClient --> RefreshingHttpClient
ControllerApi --> ApiClient
@enduml
```

### 4.4 Architecture UI - Screens et Widgets

```plantuml
@startuml
package "UI Layer" {
  abstract class StatefulWidget {
    +createState()
  }
  
  abstract class StatelessWidget {
    +build(context)
  }
  
  class HomeScreen extends StatefulWidget {
    +PageController pageController
    +int selectedIndex
    -_onItemTapped()
  }
  
  class ProductDetailsScreen extends StatefulWidget {
    +ProductDto product
    +String? selectedVariantId
    -String? selectedSize
    -List<ProductVariantDto> productVariants
    -_handleSizeSelected()
    -_handleFavoriteToggle()
  }
  
  class CartScreen extends StatefulWidget {
    -_handleIncreaseQuantity()
    -_handleDecreaseQuantity()
    -_handleRemoveItem()
    -_proceedToCheckout()
  }
  
  class LoginOptionsScreen extends StatelessWidget {
    +build(context)
  }
  
  class EmailLoginScreen extends StatefulWidget {
    -GlobalKey<FormState> formKey
    -TextEditingController emailController
    -TextEditingController passwordController
    -bool isPasswordVisible
    -bool autovalidate
    -_login()
  }
  
  class CustomButton extends StatelessWidget {
    +String text
    +VoidCallback? onPressed
    +Color? buttonColor
    +bool isLoading
  }
  
  class CustomTextField extends StatefulWidget {
    +TextEditingController? controller
    +String? labelText
    +String? hintText
    +bool isPassword
    +String? Function(String?)? validator
  }
  
  class ProductCard extends StatelessWidget {
    +ProductDto product
    +VoidCallback? onTap
    +bool showAddToCart
  }
  
  class CartItemWidget extends StatelessWidget {
    +CartItem item
    +VoidCallback? onIncrement
    +VoidCallback? onDecrement
    +VoidCallback? onRemove
  }
}

HomeScreen --> ProductDetailsScreen
ProductDetailsScreen --> CartScreen
CartScreen --> CheckoutScreen
LoginOptionsScreen --> EmailLoginScreen
@enduml
```

---

## 🔄 5. Flux de Données et Architecture

### 5.1 Architecture Globale

```plantuml
@startuml
package "Presentation Layer" {
  [Screens]
  [Widgets]
  [Pages]
}

package "State Management" {
  [BLoC Events]
  [BLoC States]
  [AuthBloc]
  [ProductBloc]
  [CartBloc]
  [OrderBloc]
  [CategoryBloc]
  [ReviewBloc]
}

package "Business Logic" {
  [Services]
  [Repositories]
  [Models]
}

package "Data Layer" {
  [API Client]
  [Local Storage]
  [Shared Preferences]
  [Keycloak]
}

package "External Systems" {
  [REST API]
  [Keycloak Server]
  [Payment Gateway]
}

[Screens] --> [BLoC Events]
[BLoC Events] --> [AuthBloc]
[BLoC Events] --> [ProductBloc]
[BLoC Events] --> [CartBloc]
[BLoC Events] --> [OrderBloc]
[BLoC Events] --> [CategoryBloc]
[BLoC Events] --> [ReviewBloc]

[AuthBloc] --> [BLoC States]
[ProductBloc] --> [BLoC States]
[CartBloc] --> [BLoC States]
[OrderBloc] --> [BLoC States]
[CategoryBloc] --> [BLoC States]
[ReviewBloc] --> [BLoC States]

[BLoC States] --> [Widgets]

[AuthBloc] --> [Services]
[ProductBloc] --> [Services]
[CartBloc] --> [Local Storage]
[OrderBloc] --> [Services]
[CategoryBloc] --> [Services]
[ReviewBloc] --> [Services]

[Services] --> [API Client]
[Services] --> [Keycloak]
[Local Storage] --> [Shared Preferences]

[API Client] --> [REST API]
[Keycloak] --> [Keycloak Server]
[Services] --> [Payment Gateway]
@enduml
```

### 5.2 Cycle de Vie d'une Requête

```plantuml
@startuml
participant "UI" as UI
participant "BLoC" as Bloc
participant "Service" as Service
participant "HTTP Client" as Client
participant "Auth Service" as Auth
participant "API" as API

UI -> Bloc: Event (ex: LoadProducts)
Bloc -> Service: Appel méthode
Service -> Client: HTTP Request
Client -> Auth: Vérifier token
alt Token valide
    Auth -> Client: Token OK
    Client -> API: Request avec token
    API -> Client: Response
    Client -> Service: Data
    Service -> Bloc: Result
    Bloc -> UI: State Update
else Token expiré
    Auth -> Client: Token expired
    Client -> Auth: Refresh token
    alt Refresh réussi
        Auth -> Client: Nouveau token
        Client -> API: Retry request
        API -> Client: Response
        Client -> Service: Data
        Service -> Bloc: Result
        Bloc -> UI: State Update
    else Refresh échoué
        Auth -> Client: Auth failed
        Client -> Service: AuthError
        Service -> Bloc: Error
        Bloc -> UI: Unauthenticated State
    end
end
@enduml
```

---

## 📱 6. Interfaces Utilisateur et Navigation

### 6.1 Flow de Navigation Principal

```plantuml
@startuml
state SplashScreen
state LoginOptionsScreen
state EmailLoginScreen
state HomeScreen
state ProductDetailsScreen
state CartScreen
state CheckoutScreen
state ProfileScreen
state MyOrdersScreen
state SearchScreen
state SavedItemsScreen

[*] --> SplashScreen
SplashScreen --> LoginOptionsScreen : Non authentifié
SplashScreen --> HomeScreen : Authentifié

LoginOptionsScreen --> EmailLoginScreen : Connexion email
EmailLoginScreen --> HomeScreen : Succès login
EmailLoginScreen --> LoginOptionsScreen : Retour

HomeScreen --> ProductDetailsScreen : Sélection produit
HomeScreen --> CartScreen : Accès panier
HomeScreen --> ProfileScreen : Accès profil
HomeScreen --> SearchScreen : Recherche
HomeScreen --> SavedItemsScreen : Favoris

ProductDetailsScreen --> CartScreen : Ajout panier
ProductDetailsScreen --> HomeScreen : Retour

CartScreen --> CheckoutScreen : Commander
CartScreen --> ProductDetailsScreen : Modifier article
CartScreen --> HomeScreen : Continuer shopping

CheckoutScreen --> MyOrdersScreen : Commande validée
CheckoutScreen --> CartScreen : Retour

ProfileScreen --> MyOrdersScreen : Mes commandes
ProfileScreen --> SavedItemsScreen : Mes favoris
ProfileScreen --> LoginOptionsScreen : Déconnexion
@enduml
```

### 6.2 Structure des Widgets Réutilisables

```plantuml
@startuml
package "Common Widgets" {
  class CustomAppBar {
    +String title
    +bool showBackButton
    +List<Widget>? actions
  }
  
  class CustomButton {
    +String text
    +VoidCallback? onPressed
    +Color? buttonColor
    +bool isLoading
    +ButtonType type
  }
  
  class CustomTextField {
    +String? labelText
    +String? hintText
    +bool isPassword
    +TextEditingController? controller
    +String? Function(String?)? validator
  }
  
  class LoadingWidget {
    +String? message
    +Color? color
  }
  
  class ErrorWidget {
    +String message
    +VoidCallback? onRetry
  }
}

package "Product Widgets" {
  class ProductCard {
    +ProductDto product
    +VoidCallback? onTap
    +bool showFavorite
  }
  
  class ProductGrid {
    +List<ProductDto> products
    +Function(ProductDto)? onProductTap
  }
  
  class ProductImageCarousel {
    +List<String> imageUrls
    +Function(int)? onPageChanged
  }
  
  class SizeSelector {
    +List<String> availableSizes
    +String? selectedSize
    +Function(String?)? onSizeSelected
  }
  
  class ColorSelector {
    +List<String> availableColors
    +String? selectedColor
    +Function(String?)? onColorSelected
  }
}

package "Cart Widgets" {
  class CartItemWidget {
    +CartItem item
    +VoidCallback? onIncrement
    +VoidCallback? onDecrement
    +VoidCallback? onRemove
  }
  
  class CartSummary {
    +List<CartItem> items
    +double subtotal
    +double shipping
    +double total
  }
}

package "Review Widgets" {
  class ReviewCard {
    +ReviewDto review
    +bool showProductInfo
  }
  
  class RatingDisplay {
    +double rating
    +int reviewCount
    +bool showText
  }
  
  class RatingInput {
    +int? selectedRating
    +Function(int)? onRatingChanged
  }
}
@enduml
```

---

## 🔧 7. Gestion des Erreurs et États

### 7.1 Hiérarchie des États BLoC

```plantuml
@startuml
abstract class BlocState

package "Auth States" {
  class AuthInitial extends BlocState
  class AuthLoading extends BlocState
  class Authenticated extends BlocState {
    +UserInfo user
  }
  class Unauthenticated extends BlocState
  class AuthError extends BlocState {
    +String message
  }
  class AuthLoggingOut extends BlocState
}

package "Product States" {
  class ProductInitial extends BlocState
  class ProductLoading extends BlocState
  class ProductLoaded extends BlocState {
    +List<ProductDto> products
    +String? searchQuery
    +String? selectedCategory
  }
  class ProductError extends BlocState {
    +String message
  }
  class ProductDetailsLoaded extends BlocState {
    +ProductDto product
    +List<ProductVariantDto> variants
  }
}

package "Cart States" {
  class CartInitial extends BlocState
  class CartLoading extends BlocState
  class CartLoaded extends BlocState {
    +List<CartItem> items
    +double total
    +int itemCount
  }
  class CartError extends BlocState {
    +String message
  }
}

package "Order States" {
  class OrderInitial extends BlocState
  class OrderCreating extends BlocState
  class OrderCreated extends BlocState {
    +OrderDto order
  }
  class OrdersLoaded extends BlocState {
    +List<OrderDto> orders
  }
  class OrderError extends BlocState {
    +String message
  }
}
@enduml
```

### 7.2 Gestion des Erreurs Réseau

```plantuml
@startuml
abstract class AppException {
  +String message
  +String? code
}

class NetworkException extends AppException {
  +NetworkExceptionType type
}

class AuthException extends AppException {
  +AuthExceptionType type
}

class ValidationException extends AppException {
  +Map<String, String> fieldErrors
}

class ApiException extends AppException {
  +int statusCode
  +String? response
}

enum NetworkExceptionType {
  NO_INTERNET
  TIMEOUT
  SERVER_ERROR
  UNKNOWN
}

enum AuthExceptionType {
  INVALID_CREDENTIALS
  TOKEN_EXPIRED
  REFRESH_FAILED
  USER_NOT_FOUND
  ACCOUNT_LOCKED
}

class ErrorHandler {
  +static handleError(error)
  +static showErrorDialog(context, error)
  +static getErrorMessage(error)
}
@enduml
```

---

## 🔄 8. Patterns et Bonnes Pratiques

### 8.1 Repository Pattern (Conceptuel)

```plantuml
@startuml
interface ProductRepository {
  +Future<List<ProductDto>> getAllProducts()
  +Future<ProductDto> getProductById(String id)
  +Future<List<ProductDto>> searchProducts(String query)
  +Future<List<ProductDto>> getProductsByCategory(String categoryId)
}

interface OrderRepository {
  +Future<OrderDto> createOrder(OrderDto order)
  +Future<List<OrderDto>> getUserOrders(String userId)
  +Future<OrderDto> getOrderById(String orderId)
  +Future<void> updateOrderStatus(String orderId, OrderStatus status)
}

class ApiProductRepository implements ProductRepository {
  -ProductControllerApi api
  +getAllProducts()
  +getProductById(id)
  +searchProducts(query)
  +getProductsByCategory(categoryId)
}

class ApiOrderRepository implements OrderRepository {
  -OrderControllerApi api
  +createOrder(order)
  +getUserOrders(userId)
  +getOrderById(orderId)
  +updateOrderStatus(orderId, status)
}

class CachedProductRepository implements ProductRepository {
  -ProductRepository repository
  -Cache cache
  +getAllProducts()
  +getProductById(id)
  +searchProducts(query)
  +getProductsByCategory(categoryId)
}
@enduml
```

### 8.2 Dependency Injection

```plantuml
@startuml
class ServiceLocator {
  -Map<Type, dynamic> services
  +static T get<T>()
  +static register<T>(T service)
  +static registerLazySingleton<T>(Factory<T> factory)
}

class AppDependencies {
  +static setupDependencies()
  +static registerServices()
  +static registerRepositories()
  +static registerBlocs()
}

note right of AppDependencies
  Configure all dependencies
  at app startup:
  - API clients
  - Services
  - Repositories
  - BLoCs
end note
@enduml
```

---

## 📋 9. Résumé et Points Clés

### Points Forts de l'Architecture

1. **Séparation des Responsabilités**
   - Couche UI distincte avec widgets réutilisables
   - BLoC pour la gestion d'état centralisée
   - Services pour la logique métier
   - Clients API pour l'accès aux données

2. **Gestion Robuste de l'Authentification**
   - Integration OAuth/OpenID Connect via Keycloak
   - Refresh automatique des tokens
   - Gestion des états d'authentification

3. **Architecture Réactive**
   - Pattern BLoC pour la gestion d'état
   - Streams pour la communication asynchrone
   - États immutables avec Equatable

4. **Persistence Locale**
   - SharedPreferences pour les préférences utilisateur
   - Sauvegarde locale du panier
   - Cache des données critiques

### Améliorations Possibles

1. **Repository Pattern**
   - Abstraire davantage l'accès aux données
   - Implémenter un cache sophistiqué
   - Gestion offline-first

2. **Testing**
   - Tests unitaires pour tous les BLoCs
   - Tests d'intégration pour les workflows
   - Tests de widgets UI

3. **Performance**
   - Lazy loading des images
   - Pagination des listes de produits
   - Optimisation des requêtes API

4. **Monitoring**
   - Logging centralisé
   - Analytics des performances
   - Crash reporting

Cette architecture UML représente une application Flutter moderne, bien structurée, qui suit les meilleures pratiques du développement mobile et offre une base solide pour l'évolutivité et la maintenance.