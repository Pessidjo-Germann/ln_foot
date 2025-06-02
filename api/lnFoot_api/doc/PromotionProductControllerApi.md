# lnFoot_api.api.PromotionProductControllerApi

## Load the API package
```dart
import 'package:lnFoot_api/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPromotionProduct**](PromotionProductControllerApi.md#createpromotionproduct) | **POST** /api/promotion-products | 
[**createPromotionProducts**](PromotionProductControllerApi.md#createpromotionproducts) | **POST** /api/promotion-products/batch | 
[**deletePromotionProduct**](PromotionProductControllerApi.md#deletepromotionproduct) | **DELETE** /api/promotion-products/{id} | 
[**getAllPromotionProducts**](PromotionProductControllerApi.md#getallpromotionproducts) | **GET** /api/promotion-products | 
[**getPromotionProductById**](PromotionProductControllerApi.md#getpromotionproductbyid) | **GET** /api/promotion-products/{id} | 
[**updatePromotionProduct**](PromotionProductControllerApi.md#updatepromotionproduct) | **PUT** /api/promotion-products/{id} | 


# **createPromotionProduct**
> PromotionProductDto createPromotionProduct(promotionProductDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionProductControllerApi();
final promotionProductDto = PromotionProductDto(); // PromotionProductDto | 

try {
    final result = api_instance.createPromotionProduct(promotionProductDto);
    print(result);
} catch (e) {
    print('Exception when calling PromotionProductControllerApi->createPromotionProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **promotionProductDto** | [**PromotionProductDto**](PromotionProductDto.md)|  | 

### Return type

[**PromotionProductDto**](PromotionProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPromotionProducts**
> List<PromotionProductDto> createPromotionProducts(promotionProductDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionProductControllerApi();
final promotionProductDto = [List<PromotionProductDto>()]; // List<PromotionProductDto> | 

try {
    final result = api_instance.createPromotionProducts(promotionProductDto);
    print(result);
} catch (e) {
    print('Exception when calling PromotionProductControllerApi->createPromotionProducts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **promotionProductDto** | [**List<PromotionProductDto>**](PromotionProductDto.md)|  | 

### Return type

[**List<PromotionProductDto>**](PromotionProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePromotionProduct**
> deletePromotionProduct(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionProductControllerApi();
final id = id_example; // String | 

try {
    api_instance.deletePromotionProduct(id);
} catch (e) {
    print('Exception when calling PromotionProductControllerApi->deletePromotionProduct: $e\n');
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

# **getAllPromotionProducts**
> List<PromotionProductDto> getAllPromotionProducts()



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionProductControllerApi();

try {
    final result = api_instance.getAllPromotionProducts();
    print(result);
} catch (e) {
    print('Exception when calling PromotionProductControllerApi->getAllPromotionProducts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<PromotionProductDto>**](PromotionProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPromotionProductById**
> PromotionProductDto getPromotionProductById(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionProductControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getPromotionProductById(id);
    print(result);
} catch (e) {
    print('Exception when calling PromotionProductControllerApi->getPromotionProductById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PromotionProductDto**](PromotionProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePromotionProduct**
> PromotionProductDto updatePromotionProduct(id, promotionProductDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionProductControllerApi();
final id = id_example; // String | 
final promotionProductDto = PromotionProductDto(); // PromotionProductDto | 

try {
    final result = api_instance.updatePromotionProduct(id, promotionProductDto);
    print(result);
} catch (e) {
    print('Exception when calling PromotionProductControllerApi->updatePromotionProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **promotionProductDto** | [**PromotionProductDto**](PromotionProductDto.md)|  | 

### Return type

[**PromotionProductDto**](PromotionProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

