# openapi.api.HighlightControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createHighlight**](HighlightControllerApi.md#createhighlight) | **POST** /api/v1/highlights | 
[**deleteHighlight**](HighlightControllerApi.md#deletehighlight) | **DELETE** /api/v1/highlights/{id} | 
[**findHighlightById**](HighlightControllerApi.md#findhighlightbyid) | **GET** /api/v1/highlights/{id} | 
[**listHighlights**](HighlightControllerApi.md#listhighlights) | **GET** /api/v1/highlights | 
[**updateHighlight**](HighlightControllerApi.md#updatehighlight) | **PUT** /api/v1/highlights/{id} | 


# **createHighlight**
> HighlightDto createHighlight(createHighlightDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HighlightControllerApi();
final createHighlightDto = CreateHighlightDto(); // CreateHighlightDto | 

try {
    final result = api_instance.createHighlight(createHighlightDto);
    print(result);
} catch (e) {
    print('Exception when calling HighlightControllerApi->createHighlight: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createHighlightDto** | [**CreateHighlightDto**](CreateHighlightDto.md)|  | 

### Return type

[**HighlightDto**](HighlightDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteHighlight**
> deleteHighlight(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HighlightControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteHighlight(id);
} catch (e) {
    print('Exception when calling HighlightControllerApi->deleteHighlight: $e\n');
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

# **findHighlightById**
> HighlightDto findHighlightById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HighlightControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.findHighlightById(id);
    print(result);
} catch (e) {
    print('Exception when calling HighlightControllerApi->findHighlightById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**HighlightDto**](HighlightDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listHighlights**
> PageHighlightDto listHighlights(pageable)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HighlightControllerApi();
final pageable = ; // Pageable | 

try {
    final result = api_instance.listHighlights(pageable);
    print(result);
} catch (e) {
    print('Exception when calling HighlightControllerApi->listHighlights: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**PageHighlightDto**](PageHighlightDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateHighlight**
> HighlightDto updateHighlight(id, updateHighlightDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HighlightControllerApi();
final id = id_example; // String | 
final updateHighlightDto = UpdateHighlightDto(); // UpdateHighlightDto | 

try {
    final result = api_instance.updateHighlight(id, updateHighlightDto);
    print(result);
} catch (e) {
    print('Exception when calling HighlightControllerApi->updateHighlight: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateHighlightDto** | [**UpdateHighlightDto**](UpdateHighlightDto.md)|  | 

### Return type

[**HighlightDto**](HighlightDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

