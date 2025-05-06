# lnFoot_api.api.PromotionControllerApi

## Load the API package
```dart
import 'package:lnFoot_api/api.dart';
```

All URIs are relative to *http://lnfoot-api.hublots.co*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPromotion**](PromotionControllerApi.md#createpromotion) | **POST** /api/promotions | 
[**createPromotions**](PromotionControllerApi.md#createpromotions) | **POST** /api/promotions/batch | 
[**deletePromotion**](PromotionControllerApi.md#deletepromotion) | **DELETE** /api/promotions/{id} | 
[**getAllPromotions**](PromotionControllerApi.md#getallpromotions) | **GET** /api/promotions | 
[**getPromotionById**](PromotionControllerApi.md#getpromotionbyid) | **GET** /api/promotions/{id} | 
[**updatePromotion**](PromotionControllerApi.md#updatepromotion) | **PUT** /api/promotions/{id} | 


# **createPromotion**
> Promotion createPromotion(promotionDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionControllerApi();
final promotionDto = PromotionDto(); // PromotionDto | 

try {
    final result = api_instance.createPromotion(promotionDto);
    print(result);
} catch (e) {
    print('Exception when calling PromotionControllerApi->createPromotion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **promotionDto** | [**PromotionDto**](PromotionDto.md)|  | 

### Return type

[**Promotion**](Promotion.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPromotions**
> List<Promotion> createPromotions(promotionDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionControllerApi();
final promotionDto = [List<PromotionDto>()]; // List<PromotionDto> | 

try {
    final result = api_instance.createPromotions(promotionDto);
    print(result);
} catch (e) {
    print('Exception when calling PromotionControllerApi->createPromotions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **promotionDto** | [**List<PromotionDto>**](PromotionDto.md)|  | 

### Return type

[**List<Promotion>**](Promotion.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePromotion**
> deletePromotion(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionControllerApi();
final id = id_example; // String | 

try {
    api_instance.deletePromotion(id);
} catch (e) {
    print('Exception when calling PromotionControllerApi->deletePromotion: $e\n');
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

# **getAllPromotions**
> List<Promotion> getAllPromotions()



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionControllerApi();

try {
    final result = api_instance.getAllPromotions();
    print(result);
} catch (e) {
    print('Exception when calling PromotionControllerApi->getAllPromotions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Promotion>**](Promotion.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPromotionById**
> Promotion getPromotionById(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getPromotionById(id);
    print(result);
} catch (e) {
    print('Exception when calling PromotionControllerApi->getPromotionById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Promotion**](Promotion.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePromotion**
> Promotion updatePromotion(id, promotionDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PromotionControllerApi();
final id = id_example; // String | 
final promotionDto = PromotionDto(); // PromotionDto | 

try {
    final result = api_instance.updatePromotion(id, promotionDto);
    print(result);
} catch (e) {
    print('Exception when calling PromotionControllerApi->updatePromotion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **promotionDto** | [**PromotionDto**](PromotionDto.md)|  | 

### Return type

[**Promotion**](Promotion.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

