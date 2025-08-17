# openapi.api.SyncControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**syncAllFixtures**](SyncControllerApi.md#syncallfixtures) | **POST** /api/v1/sync/all-fixtures | 


# **syncAllFixtures**
> SyncStatusDto syncAllFixtures(requestBody)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SyncControllerApi();
final requestBody = Map<String, String>(); // Map<String, String> | 

try {
    final result = api_instance.syncAllFixtures(requestBody);
    print(result);
} catch (e) {
    print('Exception when calling SyncControllerApi->syncAllFixtures: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**Map<String, String>**](String.md)|  | [optional] 

### Return type

[**SyncStatusDto**](SyncStatusDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

