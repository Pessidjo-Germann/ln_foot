# openapi.api.LeagueControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createLeague**](LeagueControllerApi.md#createleague) | **POST** /api/v1/leagues | 
[**deleteLeague**](LeagueControllerApi.md#deleteleague) | **DELETE** /api/v1/leagues/{id} | 
[**findLeagueById**](LeagueControllerApi.md#findleaguebyid) | **GET** /api/v1/leagues/{id} | 
[**listLeagues**](LeagueControllerApi.md#listleagues) | **GET** /api/v1/leagues | 
[**updateLeague**](LeagueControllerApi.md#updateleague) | **PUT** /api/v1/leagues/{id} | 


# **createLeague**
> LeagueDto createLeague(createLeagueDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = LeagueControllerApi();
final createLeagueDto = CreateLeagueDto(); // CreateLeagueDto | 

try {
    final result = api_instance.createLeague(createLeagueDto);
    print(result);
} catch (e) {
    print('Exception when calling LeagueControllerApi->createLeague: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createLeagueDto** | [**CreateLeagueDto**](CreateLeagueDto.md)|  | 

### Return type

[**LeagueDto**](LeagueDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteLeague**
> deleteLeague(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = LeagueControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteLeague(id);
} catch (e) {
    print('Exception when calling LeagueControllerApi->deleteLeague: $e\n');
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

# **findLeagueById**
> LeagueDto findLeagueById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = LeagueControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.findLeagueById(id);
    print(result);
} catch (e) {
    print('Exception when calling LeagueControllerApi->findLeagueById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**LeagueDto**](LeagueDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listLeagues**
> PageLeagueDto listLeagues(pageable, country, type)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = LeagueControllerApi();
final pageable = ; // Pageable | 
final country = country_example; // String | 
final type = type_example; // String | 

try {
    final result = api_instance.listLeagues(pageable, country, type);
    print(result);
} catch (e) {
    print('Exception when calling LeagueControllerApi->listLeagues: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **country** | **String**|  | [optional] 
 **type** | **String**|  | [optional] 

### Return type

[**PageLeagueDto**](PageLeagueDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateLeague**
> LeagueDto updateLeague(id, updateLeagueDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = LeagueControllerApi();
final id = id_example; // String | 
final updateLeagueDto = UpdateLeagueDto(); // UpdateLeagueDto | 

try {
    final result = api_instance.updateLeague(id, updateLeagueDto);
    print(result);
} catch (e) {
    print('Exception when calling LeagueControllerApi->updateLeague: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateLeagueDto** | [**UpdateLeagueDto**](UpdateLeagueDto.md)|  | 

### Return type

[**LeagueDto**](LeagueDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

