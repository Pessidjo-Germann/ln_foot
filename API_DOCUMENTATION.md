# 📖 Documentation API - LN FOOT Shop

## 🌐 Vue d'Ensemble de l'API

### Configuration de Base
- **URL Base** : `https://api.ln-foot.com/v1`
- **Authentification** : Bearer Token (JWT via Keycloak)
- **Format** : JSON
- **Protocole** : HTTPS uniquement

### Headers Requis
```http
Authorization: Bearer {access_token}
Content-Type: application/json
Accept: application/json
```

## 🔐 Authentification

### Flux OAuth 2.0 / OpenID Connect via Keycloak

#### 1. Authorization Code Flow
```http
GET https://auth.ln-foot.com/realms/lnfoot/protocol/openid-connect/auth
?client_id=ln-foot-01
&redirect_uri=com.lnfoot://oauth/redirect
&response_type=code
&scope=openid profile email offline_access
&state={random_state}
&code_challenge={code_challenge}
&code_challenge_method=S256
```

#### 2. Token Exchange
```http
POST https://auth.ln-foot.com/realms/lnfoot/protocol/openid-connect/token
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code
&client_id=ln-foot-01
&code={authorization_code}
&redirect_uri=com.lnfoot://oauth/redirect
&code_verifier={code_verifier}
```

**Réponse :**
```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 300,
  "refresh_expires_in": 1800,
  "scope": "openid profile email offline_access"
}
```

#### 3. Refresh Token
```http
POST https://auth.ln-foot.com/realms/lnfoot/protocol/openid-connect/token
Content-Type: application/x-www-form-urlencoded

grant_type=refresh_token
&client_id=ln-foot-01
&refresh_token={refresh_token}
```

#### 4. User Info
```http
GET https://auth.ln-foot.com/realms/lnfoot/protocol/openid-connect/userinfo
Authorization: Bearer {access_token}
```

**Réponse :**
```json
{
  "sub": "12345678-1234-1234-1234-123456789abc",
  "email": "user@example.com",
  "given_name": "John",
  "family_name": "Doe",
  "preferred_username": "johndoe",
  "email_verified": true
}
```

## 🛍️ API Produits

### GET /products
Récupère la liste des produits avec pagination et filtres.

```http
GET /api/v1/products?page=1&limit=20&category=shoes&search=nike
Authorization: Bearer {access_token}
```

**Paramètres de Requête :**
- `page` (integer, optional) : Numéro de page (défaut: 1)
- `limit` (integer, optional) : Nombre d'éléments par page (défaut: 20, max: 100)
- `category` (string, optional) : Filtre par catégorie
- `search` (string, optional) : Recherche textuelle
- `sort` (string, optional) : Tri (`price_asc`, `price_desc`, `name`, `newest`)
- `min_price` (number, optional) : Prix minimum
- `max_price` (number, optional) : Prix maximum

**Réponse :**
```json
{
  "status": "success",
  "data": {
    "products": [
      {
        "id": "prod_123",
        "name": "Nike Air Max 270",
        "description": "Chaussures de sport confortables",
        "price": 129.99,
        "currency": "EUR",
        "category": {
          "id": "cat_shoes",
          "name": "Chaussures",
          "slug": "shoes"
        },
        "images": [
          {
            "url": "https://cdn.ln-foot.com/products/prod_123/main.jpg",
            "alt": "Nike Air Max 270 - Vue principale",
            "order": 1
          }
        ],
        "variants": [
          {
            "id": "var_123_1",
            "size": "42",
            "color": "Noir",
            "stock": 5,
            "sku": "NIKE-AM270-42-BLK"
          }
        ],
        "stock_total": 5,
        "is_available": true,
        "created_at": "2025-06-01T10:00:00Z",
        "updated_at": "2025-06-03T14:30:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 95,
      "items_per_page": 20,
      "has_next": true,
      "has_previous": false
    }
  }
}
```

### GET /products/{id}
Récupère les détails d'un produit spécifique.

```http
GET /api/v1/products/prod_123
Authorization: Bearer {access_token}
```

**Réponse :**
```json
{
  "status": "success",
  "data": {
    "product": {
      "id": "prod_123",
      "name": "Nike Air Max 270",
      "description": "Chaussures de sport confortables avec technologie Air Max pour un amorti optimal.",
      "long_description": "Les Nike Air Max 270 offrent un confort exceptionnel...",
      "price": 129.99,
      "currency": "EUR",
      "category": {
        "id": "cat_shoes",
        "name": "Chaussures",
        "slug": "shoes"
      },
      "brand": {
        "id": "brand_nike",
        "name": "Nike",
        "logo": "https://cdn.ln-foot.com/brands/nike-logo.png"
      },
      "images": [
        {
          "url": "https://cdn.ln-foot.com/products/prod_123/main.jpg",
          "alt": "Nike Air Max 270 - Vue principale",
          "order": 1
        },
        {
          "url": "https://cdn.ln-foot.com/products/prod_123/side.jpg", 
          "alt": "Nike Air Max 270 - Vue de côté",
          "order": 2
        }
      ],
      "variants": [
        {
          "id": "var_123_1",
          "size": "42",
          "color": "Noir", 
          "stock": 5,
          "sku": "NIKE-AM270-42-BLK",
          "price_modifier": 0
        },
        {
          "id": "var_123_2",
          "size": "43",
          "color": "Blanc",
          "stock": 3,
          "sku": "NIKE-AM270-43-WHT", 
          "price_modifier": 0
        }
      ],
      "specifications": {
        "material": "Textile et synthétique",
        "weight": "350g",
        "technology": ["Air Max", "Flyknit"]
      },
      "reviews": {
        "average_rating": 4.5,
        "total_reviews": 127,
        "rating_distribution": {
          "5": 78,
          "4": 32,
          "3": 12,
          "2": 3,
          "1": 2
        }
      },
      "stock_total": 8,
      "is_available": true,
      "is_featured": true,
      "tags": ["sport", "running", "lifestyle"],
      "created_at": "2025-06-01T10:00:00Z",
      "updated_at": "2025-06-03T14:30:00Z"
    }
  }
}
```

## 📂 API Catégories

### GET /categories
Récupère la liste des catégories.

```http
GET /api/v1/categories
Authorization: Bearer {access_token}
```

**Réponse :**
```json
{
  "status": "success",
  "data": {
    "categories": [
      {
        "id": "cat_shoes",
        "name": "Chaussures",
        "slug": "shoes",
        "description": "Toutes les chaussures de sport",
        "image": "https://cdn.ln-foot.com/categories/shoes.jpg",
        "product_count": 45,
        "subcategories": [
          {
            "id": "cat_running",
            "name": "Running",
            "slug": "running",
            "product_count": 23
          }
        ],
        "is_active": true,
        "sort_order": 1
      }
    ]
  }
}
```

## 🛒 API Panier

### GET /cart
Récupère le contenu du panier de l'utilisateur.

```http
GET /api/v1/cart
Authorization: Bearer {access_token}
```

**Réponse :**
```json
{
  "status": "success",
  "data": {
    "cart": {
      "id": "cart_user_123",
      "user_id": "user_123",
      "items": [
        {
          "id": "item_1",
          "product": {
            "id": "prod_123",
            "name": "Nike Air Max 270",
            "price": 129.99,
            "image": "https://cdn.ln-foot.com/products/prod_123/main.jpg"
          },
          "variant": {
            "id": "var_123_1",
            "size": "42",
            "color": "Noir",
            "sku": "NIKE-AM270-42-BLK"
          },
          "quantity": 2,
          "unit_price": 129.99,
          "total_price": 259.98,
          "added_at": "2025-06-03T10:00:00Z"
        }
      ],
      "summary": {
        "items_count": 2,
        "subtotal": 259.98,
        "shipping": 9.99,
        "tax": 25.99,
        "total": 295.96,
        "currency": "EUR"
      },
      "created_at": "2025-06-03T09:00:00Z",
      "updated_at": "2025-06-03T10:00:00Z"
    }
  }
}
```

### POST /cart/items
Ajoute un article au panier.

```http
POST /api/v1/cart/items
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "product_id": "prod_123",
  "variant_id": "var_123_1",
  "quantity": 1
}
```

**Réponse :**
```json
{
  "status": "success",
  "message": "Article ajouté au panier",
  "data": {
    "item": {
      "id": "item_2",
      "product_id": "prod_123",
      "variant_id": "var_123_1",
      "quantity": 1,
      "unit_price": 129.99,
      "total_price": 129.99
    },
    "cart_summary": {
      "items_count": 3,
      "total": 425.95
    }
  }
}
```

### PUT /cart/items/{item_id}
Met à jour la quantité d'un article dans le panier.

```http
PUT /api/v1/cart/items/item_1
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "quantity": 3
}
```

### DELETE /cart/items/{item_id}
Supprime un article du panier.

```http
DELETE /api/v1/cart/items/item_1
Authorization: Bearer {access_token}
```

## 📦 API Commandes

### POST /orders
Crée une nouvelle commande.

```http
POST /api/v1/orders
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "shipping_address": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "",
    "address_line_1": "123 Rue Example",
    "address_line_2": "",
    "city": "Paris",
    "postal_code": "75001",
    "country": "FR",
    "phone": "+33123456789"
  },
  "billing_address": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "",
    "address_line_1": "123 Rue Example",
    "address_line_2": "",
    "city": "Paris",
    "postal_code": "75001",
    "country": "FR",
    "phone": "+33123456789"
  },
  "payment_method": "stripe",
  "shipping_method": "standard",
  "notes": "Livrer le matin si possible"
}
```

**Réponse :**
```json
{
  "status": "success",
  "message": "Commande créée avec succès",
  "data": {
    "order": {
      "id": "order_456",
      "order_number": "LNF-2025-001234",
      "status": "pending_payment",
      "user_id": "user_123",
      "items": [
        {
          "product": {
            "id": "prod_123",
            "name": "Nike Air Max 270"
          },
          "variant": {
            "size": "42",
            "color": "Noir"
          },
          "quantity": 2,
          "unit_price": 129.99,
          "total_price": 259.98
        }
      ],
      "summary": {
        "subtotal": 259.98,
        "shipping": 9.99,
        "tax": 25.99,
        "total": 295.96,
        "currency": "EUR"
      },
      "payment": {
        "method": "stripe",
        "status": "pending",
        "payment_intent_id": "pi_1234567890"
      },
      "shipping_address": {
        "first_name": "John",
        "last_name": "Doe",
        "address_line_1": "123 Rue Example",
        "city": "Paris",
        "postal_code": "75001",
        "country": "FR"
      },
      "estimated_delivery": "2025-06-10",
      "created_at": "2025-06-03T11:00:00Z"
    }
  }
}
```

### GET /orders
Récupère l'historique des commandes de l'utilisateur.

```http
GET /api/v1/orders?page=1&limit=10&status=completed
Authorization: Bearer {access_token}
```

### GET /orders/{order_id}
Récupère les détails d'une commande spécifique.

```http
GET /api/v1/orders/order_456
Authorization: Bearer {access_token}
```

## ❤️ API Articles Sauvegardés

### GET /wishlist
Récupère la liste des articles sauvegardés.

```http
GET /api/v1/wishlist
Authorization: Bearer {access_token}
```

### POST /wishlist
Ajoute un produit aux favoris.

```http
POST /api/v1/wishlist
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "product_id": "prod_123"
}
```

### DELETE /wishlist/{product_id}
Supprime un produit des favoris.

```http
DELETE /api/v1/wishlist/prod_123
Authorization: Bearer {access_token}
```

## 🔍 API Recherche

### GET /search
Recherche globale dans les produits.

```http
GET /api/v1/search?q=nike+air&category=shoes&min_price=50&max_price=200
Authorization: Bearer {access_token}
```

**Paramètres :**
- `q` (string, required) : Terme de recherche
- `category` (string, optional) : Filtre par catégorie
- `brand` (string, optional) : Filtre par marque
- `min_price` (number, optional) : Prix minimum
- `max_price` (number, optional) : Prix maximum
- `sort` (string, optional) : Tri des résultats
- `page` (integer, optional) : Pagination
- `limit` (integer, optional) : Limite par page

## 📊 Codes d'Erreur

### Erreurs Communes

#### 400 - Bad Request
```json
{
  "status": "error",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Les données envoyées sont invalides",
    "details": {
      "quantity": ["La quantité doit être supérieure à 0"],
      "product_id": ["Ce produit n'existe pas"]
    }
  }
}
```

#### 401 - Unauthorized
```json
{
  "status": "error",
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Token d'authentification invalide ou expiré",
    "details": "Veuillez vous reconnecter"
  }
}
```

#### 403 - Forbidden
```json
{
  "status": "error",
  "error": {
    "code": "FORBIDDEN",
    "message": "Accès non autorisé à cette ressource",
    "details": "Vous n'avez pas les permissions nécessaires"
  }
}
```

#### 404 - Not Found
```json
{
  "status": "error",
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "La ressource demandée n'existe pas",
    "details": "Produit avec l'ID 'prod_999' introuvable"
  }
}
```

#### 429 - Too Many Requests
```json
{
  "status": "error",
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Trop de requêtes envoyées",
    "details": "Limitez vos requêtes à 100 par minute",
    "retry_after": 60
  }
}
```

#### 500 - Internal Server Error
```json
{
  "status": "error",
  "error": {
    "code": "INTERNAL_ERROR",
    "message": "Une erreur interne s'est produite",
    "details": "Veuillez réessayer plus tard ou contacter le support",
    "reference_id": "err_123456789"
  }
}
```

## 🔄 Pagination Standard

Toutes les APIs paginées utilisent le même format :

```json
{
  "pagination": {
    "current_page": 1,
    "total_pages": 5,
    "total_items": 95,
    "items_per_page": 20,
    "has_next": true,
    "has_previous": false
  }
}
```

## 🕒 Rate Limiting

- **Limite générale** : 1000 requêtes par heure par utilisateur
- **Limite recherche** : 100 requêtes par minute  
- **Limite authentification** : 10 tentatives par minute
- **Headers de réponse** :
  - `X-RateLimit-Limit` : Limite totale
  - `X-RateLimit-Remaining` : Requêtes restantes
  - `X-RateLimit-Reset` : Timestamp de reset

## 📱 Client API Flutter

### Configuration
```dart
final apiClient = ApiClient(
  basePath: 'https://api.ln-foot.com/v1',
  authentication: HttpBearerAuth()..accessToken = accessToken,
);
```

### Utilisation avec RefreshingHttpClient
```dart
final refreshingClient = RefreshingHttpClient(
  http.Client(),
  authService,
);

final apiClient = ApiClient(
  basePath: 'https://api.ln-foot.com/v1',
  httpClient: refreshingClient,
);
```

---

*Documentation API mise à jour le 3 juin 2025 - Version 1.0*
