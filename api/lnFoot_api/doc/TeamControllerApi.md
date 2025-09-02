# openapi.api.TeamControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**findTeamById**](TeamControllerApi.md#findteambyid) | **GET** /api/v1/teams/{id} | 
[**listTeams**](TeamControllerApi.md#listteams) | **GET** /api/v1/teams | 


# **findTeamById**
> TeamDto findTeamById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = TeamControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.findTeamById(id);
    print(result);
} catch (e) {
    print('Exception when calling TeamControllerApi->findTeamById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TeamDto**](TeamDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTeams**
> List<TeamDto> listTeams(leagueId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = TeamControllerApi();
final leagueId = leagueId_example; // String | 

try {
    final result = api_instance.listTeams(leagueId);
    print(result);
} catch (e) {
    print('Exception when calling TeamControllerApi->listTeams: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **leagueId** | **String**|  | [optional] 

### Return type

[**List<TeamDto>**](TeamDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

