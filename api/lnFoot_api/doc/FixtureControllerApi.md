# openapi.api.FixtureControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createFixture**](FixtureControllerApi.md#createfixture) | **POST** /api/v1/fixtures | 
[**deleteFixture**](FixtureControllerApi.md#deletefixture) | **DELETE** /api/v1/fixtures/{id} | 
[**findFixtureById**](FixtureControllerApi.md#findfixturebyid) | **GET** /api/v1/fixtures/{id} | 
[**getFixturesByDate**](FixtureControllerApi.md#getfixturesbydate) | **GET** /api/v1/fixtures/by-date | 
[**getUpcomingFixtures**](FixtureControllerApi.md#getupcomingfixtures) | **GET** /api/v1/fixtures/upcoming | 
[**listFixtures**](FixtureControllerApi.md#listfixtures) | **GET** /api/v1/fixtures | 
[**updateFixture**](FixtureControllerApi.md#updatefixture) | **PUT** /api/v1/fixtures/{id} | 


# **createFixture**
> FixtureDto createFixture(createFixtureDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FixtureControllerApi();
final createFixtureDto = CreateFixtureDto(); // CreateFixtureDto | 

try {
    final result = api_instance.createFixture(createFixtureDto);
    print(result);
} catch (e) {
    print('Exception when calling FixtureControllerApi->createFixture: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createFixtureDto** | [**CreateFixtureDto**](CreateFixtureDto.md)|  | 

### Return type

[**FixtureDto**](FixtureDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFixture**
> deleteFixture(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FixtureControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteFixture(id);
} catch (e) {
    print('Exception when calling FixtureControllerApi->deleteFixture: $e\n');
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

# **findFixtureById**
> FixtureDto findFixtureById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FixtureControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.findFixtureById(id);
    print(result);
} catch (e) {
    print('Exception when calling FixtureControllerApi->findFixtureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**FixtureDto**](FixtureDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFixturesByDate**
> List<FixtureDto> getFixturesByDate(date, leagueId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FixtureControllerApi();
final date = 2013-10-20; // DateTime | 
final leagueId = leagueId_example; // String | 

try {
    final result = api_instance.getFixturesByDate(date, leagueId);
    print(result);
} catch (e) {
    print('Exception when calling FixtureControllerApi->getFixturesByDate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **DateTime**|  | 
 **leagueId** | **String**|  | [optional] 

### Return type

[**List<FixtureDto>**](FixtureDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUpcomingFixtures**
> List<FixtureDto> getUpcomingFixtures(days, leagueId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FixtureControllerApi();
final days = 56; // int | 
final leagueId = leagueId_example; // String | 

try {
    final result = api_instance.getUpcomingFixtures(days, leagueId);
    print(result);
} catch (e) {
    print('Exception when calling FixtureControllerApi->getUpcomingFixtures: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **days** | **int**|  | [optional] [default to 7]
 **leagueId** | **String**|  | [optional] 

### Return type

[**List<FixtureDto>**](FixtureDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listFixtures**
> PageFixtureDto listFixtures(pageable, leagueApiId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FixtureControllerApi();
final pageable = ; // Pageable | 
final leagueApiId = leagueApiId_example; // String | 

try {
    final result = api_instance.listFixtures(pageable, leagueApiId);
    print(result);
} catch (e) {
    print('Exception when calling FixtureControllerApi->listFixtures: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **leagueApiId** | **String**|  | [optional] 

### Return type

[**PageFixtureDto**](PageFixtureDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateFixture**
> FixtureDto updateFixture(id, updateFixtureDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FixtureControllerApi();
final id = id_example; // String | 
final updateFixtureDto = UpdateFixtureDto(); // UpdateFixtureDto | 

try {
    final result = api_instance.updateFixture(id, updateFixtureDto);
    print(result);
} catch (e) {
    print('Exception when calling FixtureControllerApi->updateFixture: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateFixtureDto** | [**UpdateFixtureDto**](UpdateFixtureDto.md)|  | 

### Return type

[**FixtureDto**](FixtureDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

