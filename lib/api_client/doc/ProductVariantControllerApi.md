# openapi.api.ProductVariantControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createProductVariant**](ProductVariantControllerApi.md#createproductvariant) | **POST** /api/product-variants | 
[**createProductVariants**](ProductVariantControllerApi.md#createproductvariants) | **POST** /api/product-variants/bulk | 
[**deleteProductVariant**](ProductVariantControllerApi.md#deleteproductvariant) | **DELETE** /api/product-variants/{id} | 
[**getProductVariant**](ProductVariantControllerApi.md#getproductvariant) | **GET** /api/product-variants/{id} | 
[**getProductVariants**](ProductVariantControllerApi.md#getproductvariants) | **GET** /api/product-variants | 
[**updateProductVariant**](ProductVariantControllerApi.md#updateproductvariant) | **PUT** /api/product-variants/{id} | 


# **createProductVariant**
> ProductVariantDto createProductVariant(price, id, imageUrl, file, colorCode, productId, stockQuantity, sizes)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final price = 8.14; // num | 
final id = id_example; // String | 
final imageUrl = imageUrl_example; // String | 
final file = BINARY_DATA_HERE; // MultipartFile | 
final colorCode = colorCode_example; // String | 
final productId = productId_example; // String | 
final stockQuantity = 56; // int | 
final sizes = []; // List<String> | 

try {
    final result = api_instance.createProductVariant(price, id, imageUrl, file, colorCode, productId, stockQuantity, sizes);
    print(result);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->createProductVariant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **price** | **num**|  | 
 **id** | **String**|  | [optional] 
 **imageUrl** | **String**|  | [optional] 
 **file** | **MultipartFile**|  | [optional] 
 **colorCode** | **String**|  | [optional] 
 **productId** | **String**|  | [optional] 
 **stockQuantity** | **int**|  | [optional] 
 **sizes** | [**List<String>**](String.md)|  | [optional] 

### Return type

[**ProductVariantDto**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createProductVariants**
> List<ProductVariantDto> createProductVariants(variants)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final variants = []; // List<ProductVariantDto> | 

try {
    final result = api_instance.createProductVariants(variants);
    print(result);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->createProductVariants: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **variants** | [**List<ProductVariantDto>**](ProductVariantDto.md)|  | 

### Return type

[**List<ProductVariantDto>**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteProductVariant**
> deleteProductVariant(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteProductVariant(id);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->deleteProductVariant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductVariant**
> ProductVariantDto getProductVariant(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getProductVariant(id);
    print(result);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->getProductVariant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ProductVariantDto**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductVariants**
> List<ProductVariantDto> getProductVariants(productId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final productId = productId_example; // String | 

try {
    final result = api_instance.getProductVariants(productId);
    print(result);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->getProductVariants: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productId** | **String**|  | [optional] 

### Return type

[**List<ProductVariantDto>**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProductVariant**
> ProductVariantDto updateProductVariant(id, productVariantDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final id = id_example; // String | 
final productVariantDto = ProductVariantDto(); // ProductVariantDto | 

try {
    final result = api_instance.updateProductVariant(id, productVariantDto);
    print(result);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->updateProductVariant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **productVariantDto** | [**ProductVariantDto**](ProductVariantDto.md)|  | [optional] 

### Return type

[**ProductVariantDto**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

