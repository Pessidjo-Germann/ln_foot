# openapi.api.AdvertisementControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createAdvertisement**](AdvertisementControllerApi.md#createadvertisement) | **POST** /api/v1/advertisements | 
[**deleteAdvertisement**](AdvertisementControllerApi.md#deleteadvertisement) | **DELETE** /api/v1/advertisements/{id} | 
[**getAdvertisementById**](AdvertisementControllerApi.md#getadvertisementbyid) | **GET** /api/v1/advertisements/{id} | 
[**getLatestAdvertisements**](AdvertisementControllerApi.md#getlatestadvertisements) | **GET** /api/v1/advertisements/latest | 
[**updateAdvertisement**](AdvertisementControllerApi.md#updateadvertisement) | **PUT** /api/v1/advertisements/{id} | 


# **createAdvertisement**
> AdvertisementDto createAdvertisement(createAdvertisementDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AdvertisementControllerApi();
final createAdvertisementDto = CreateAdvertisementDto(); // CreateAdvertisementDto | 

try {
    final result = api_instance.createAdvertisement(createAdvertisementDto);
    print(result);
} catch (e) {
    print('Exception when calling AdvertisementControllerApi->createAdvertisement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAdvertisementDto** | [**CreateAdvertisementDto**](CreateAdvertisementDto.md)|  | 

### Return type

[**AdvertisementDto**](AdvertisementDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAdvertisement**
> deleteAdvertisement(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AdvertisementControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteAdvertisement(id);
} catch (e) {
    print('Exception when calling AdvertisementControllerApi->deleteAdvertisement: $e\n');
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

# **getAdvertisementById**
> AdvertisementDto getAdvertisementById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AdvertisementControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getAdvertisementById(id);
    print(result);
} catch (e) {
    print('Exception when calling AdvertisementControllerApi->getAdvertisementById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AdvertisementDto**](AdvertisementDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLatestAdvertisements**
> PageAdvertisementDto getLatestAdvertisements(pageable)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AdvertisementControllerApi();
final pageable = ; // Pageable | 

try {
    final result = api_instance.getLatestAdvertisements(pageable);
    print(result);
} catch (e) {
    print('Exception when calling AdvertisementControllerApi->getLatestAdvertisements: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageAdvertisementDto**](PageAdvertisementDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAdvertisement**
> Object updateAdvertisement(id, updateAdvertisementDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AdvertisementControllerApi();
final id = id_example; // String | 
final updateAdvertisementDto = UpdateAdvertisementDto(); // UpdateAdvertisementDto | 

try {
    final result = api_instance.updateAdvertisement(id, updateAdvertisementDto);
    print(result);
} catch (e) {
    print('Exception when calling AdvertisementControllerApi->updateAdvertisement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateAdvertisementDto** | [**UpdateAdvertisementDto**](UpdateAdvertisementDto.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

