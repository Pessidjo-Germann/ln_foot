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
> ProductVariantDto createProductVariant(productVariantDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final productVariantDto = ProductVariantDto(); // ProductVariantDto | 

try {
    final result = api_instance.createProductVariant(productVariantDto);
    print(result);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->createProductVariant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productVariantDto** | [**ProductVariantDto**](ProductVariantDto.md)|  | 

### Return type

[**ProductVariantDto**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createProductVariants**
> List<ProductVariantDto> createProductVariants(bulkProductVariantDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductVariantControllerApi();
final bulkProductVariantDto = BulkProductVariantDto(); // BulkProductVariantDto | 

try {
    final result = api_instance.createProductVariants(bulkProductVariantDto);
    print(result);
} catch (e) {
    print('Exception when calling ProductVariantControllerApi->createProductVariants: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bulkProductVariantDto** | [**BulkProductVariantDto**](BulkProductVariantDto.md)|  | 

### Return type

[**List<ProductVariantDto>**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

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
 **productVariantDto** | [**ProductVariantDto**](ProductVariantDto.md)|  | 

### Return type

[**ProductVariantDto**](ProductVariantDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

