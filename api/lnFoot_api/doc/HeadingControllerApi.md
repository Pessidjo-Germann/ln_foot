# lnFoot_api.api.HeadingControllerApi

## Load the API package
```dart
import 'package:lnFoot_api/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createHeading**](HeadingControllerApi.md#createheading) | **POST** /api/headings | 
[**deleteHeading**](HeadingControllerApi.md#deleteheading) | **DELETE** /api/headings/{id} | 
[**getHeadings**](HeadingControllerApi.md#getheadings) | **GET** /api/headings | 
[**getOrderById1**](HeadingControllerApi.md#getorderbyid1) | **GET** /api/headings/{id} | 


# **createHeading**
> HeadingDto createHeading(headingDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HeadingControllerApi();
final headingDto = HeadingDto(); // HeadingDto | 

try {
    final result = api_instance.createHeading(headingDto);
    print(result);
} catch (e) {
    print('Exception when calling HeadingControllerApi->createHeading: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **headingDto** | [**HeadingDto**](HeadingDto.md)|  | 

### Return type

[**HeadingDto**](HeadingDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteHeading**
> deleteHeading(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HeadingControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteHeading(id);
} catch (e) {
    print('Exception when calling HeadingControllerApi->deleteHeading: $e\n');
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

# **getHeadings**
> List<HeadingDto> getHeadings()



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HeadingControllerApi();

try {
    final result = api_instance.getHeadings();
    print(result);
} catch (e) {
    print('Exception when calling HeadingControllerApi->getHeadings: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<HeadingDto>**](HeadingDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrderById1**
> HeadingDto getOrderById1(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = HeadingControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getOrderById1(id);
    print(result);
} catch (e) {
    print('Exception when calling HeadingControllerApi->getOrderById1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**HeadingDto**](HeadingDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

