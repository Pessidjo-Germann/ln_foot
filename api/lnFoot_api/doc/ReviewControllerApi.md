# openapi.api.ReviewControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://lnfoot-api.hublots.co*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createReview**](ReviewControllerApi.md#createreview) | **POST** /api/reviews | 
[**deleteReview**](ReviewControllerApi.md#deletereview) | **DELETE** /api/reviews/{id} | 
[**getAllReviews**](ReviewControllerApi.md#getallreviews) | **GET** /api/reviews | 
[**getReviewById**](ReviewControllerApi.md#getreviewbyid) | **GET** /api/reviews/{id} | 
[**updateReview**](ReviewControllerApi.md#updatereview) | **PUT** /api/reviews/{id} | 


# **createReview**
> ReviewDto createReview(userId, reviewDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ReviewControllerApi();
final userId = userId_example; // String | 
final reviewDto = ReviewDto(); // ReviewDto | 

try {
    final result = api_instance.createReview(userId, reviewDto);
    print(result);
} catch (e) {
    print('Exception when calling ReviewControllerApi->createReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **reviewDto** | [**ReviewDto**](ReviewDto.md)|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteReview**
> deleteReview(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ReviewControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteReview(id);
} catch (e) {
    print('Exception when calling ReviewControllerApi->deleteReview: $e\n');
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

# **getAllReviews**
> List<ReviewDto> getAllReviews()



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ReviewControllerApi();

try {
    final result = api_instance.getAllReviews();
    print(result);
} catch (e) {
    print('Exception when calling ReviewControllerApi->getAllReviews: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ReviewDto>**](ReviewDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReviewById**
> ReviewDto getReviewById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ReviewControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getReviewById(id);
    print(result);
} catch (e) {
    print('Exception when calling ReviewControllerApi->getReviewById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateReview**
> ReviewDto updateReview(id, userId, reviewDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ReviewControllerApi();
final id = id_example; // String | 
final userId = userId_example; // String | 
final reviewDto = ReviewDto(); // ReviewDto | 

try {
    final result = api_instance.updateReview(id, userId, reviewDto);
    print(result);
} catch (e) {
    print('Exception when calling ReviewControllerApi->updateReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userId** | **String**|  | 
 **reviewDto** | [**ReviewDto**](ReviewDto.md)|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

