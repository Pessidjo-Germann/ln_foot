# lnfoot_api.api.SizeControllerApi

## Load the API package
```dart
import 'package:lnfoot_api/api.dart';
```

All URIs are relative to *https://lnfoot-api.hublots.co*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSize**](SizeControllerApi.md#createsize) | **POST** /api/sizes | 
[**deleteSize**](SizeControllerApi.md#deletesize) | **DELETE** /api/sizes/{id} | 
[**getAllSizes**](SizeControllerApi.md#getallsizes) | **GET** /api/sizes | 
[**getSizeById**](SizeControllerApi.md#getsizebyid) | **GET** /api/sizes/{id} | 
[**updateSize**](SizeControllerApi.md#updatesize) | **PUT** /api/sizes/{id} | 


# **createSize**
> SizeDto createSize(sizeDto)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SizeControllerApi();
final sizeDto = SizeDto(); // SizeDto | 

try {
    final result = api_instance.createSize(sizeDto);
    print(result);
} catch (e) {
    print('Exception when calling SizeControllerApi->createSize: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sizeDto** | [**SizeDto**](SizeDto.md)|  | 

### Return type

[**SizeDto**](SizeDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSize**
> deleteSize(id)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SizeControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteSize(id);
} catch (e) {
    print('Exception when calling SizeControllerApi->deleteSize: $e\n');
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

# **getAllSizes**
> List<SizeDto> getAllSizes()



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SizeControllerApi();

try {
    final result = api_instance.getAllSizes();
    print(result);
} catch (e) {
    print('Exception when calling SizeControllerApi->getAllSizes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<SizeDto>**](SizeDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSizeById**
> SizeDto getSizeById(id)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SizeControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getSizeById(id);
    print(result);
} catch (e) {
    print('Exception when calling SizeControllerApi->getSizeById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SizeDto**](SizeDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSize**
> SizeDto updateSize(id, sizeDto)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SizeControllerApi();
final id = id_example; // String | 
final sizeDto = SizeDto(); // SizeDto | 

try {
    final result = api_instance.updateSize(id, sizeDto);
    print(result);
} catch (e) {
    print('Exception when calling SizeControllerApi->updateSize: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **sizeDto** | [**SizeDto**](SizeDto.md)|  | 

### Return type

[**SizeDto**](SizeDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

