# openapi.api.NewsArticleControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createNewsArticle**](NewsArticleControllerApi.md#createnewsarticle) | **POST** /api/v1/news-articles | 
[**deleteNewsArticle**](NewsArticleControllerApi.md#deletenewsarticle) | **DELETE** /api/v1/news-articles/{id} | 
[**findNewsArticleById**](NewsArticleControllerApi.md#findnewsarticlebyid) | **GET** /api/v1/news-articles/{id} | 
[**listNewsArticles**](NewsArticleControllerApi.md#listnewsarticles) | **GET** /api/v1/news-articles | 
[**updateNewsArticle**](NewsArticleControllerApi.md#updatenewsarticle) | **PUT** /api/v1/news-articles/{id} | 


# **createNewsArticle**
> NewsArticleDto createNewsArticle(createNewsArticleDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = NewsArticleControllerApi();
final createNewsArticleDto = CreateNewsArticleDto(); // CreateNewsArticleDto | 

try {
    final result = api_instance.createNewsArticle(createNewsArticleDto);
    print(result);
} catch (e) {
    print('Exception when calling NewsArticleControllerApi->createNewsArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createNewsArticleDto** | [**CreateNewsArticleDto**](CreateNewsArticleDto.md)|  | 

### Return type

[**NewsArticleDto**](NewsArticleDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteNewsArticle**
> deleteNewsArticle(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = NewsArticleControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteNewsArticle(id);
} catch (e) {
    print('Exception when calling NewsArticleControllerApi->deleteNewsArticle: $e\n');
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

# **findNewsArticleById**
> NewsArticleDto findNewsArticleById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = NewsArticleControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.findNewsArticleById(id);
    print(result);
} catch (e) {
    print('Exception when calling NewsArticleControllerApi->findNewsArticleById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**NewsArticleDto**](NewsArticleDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listNewsArticles**
> List<NewsArticleDto> listNewsArticles(status)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = NewsArticleControllerApi();
final status = status_example; // String | 

try {
    final result = api_instance.listNewsArticles(status);
    print(result);
} catch (e) {
    print('Exception when calling NewsArticleControllerApi->listNewsArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 

### Return type

[**List<NewsArticleDto>**](NewsArticleDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateNewsArticle**
> NewsArticleDto updateNewsArticle(id, updateNewsArticleDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = NewsArticleControllerApi();
final id = id_example; // String | 
final updateNewsArticleDto = UpdateNewsArticleDto(); // UpdateNewsArticleDto | 

try {
    final result = api_instance.updateNewsArticle(id, updateNewsArticleDto);
    print(result);
} catch (e) {
    print('Exception when calling NewsArticleControllerApi->updateNewsArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateNewsArticleDto** | [**UpdateNewsArticleDto**](UpdateNewsArticleDto.md)|  | 

### Return type

[**NewsArticleDto**](NewsArticleDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

