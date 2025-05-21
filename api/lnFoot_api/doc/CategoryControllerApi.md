# lnfoot_api.api.CategoryControllerApi

## Load the API package
```dart
import 'package:lnfoot_api/api.dart';
```

All URIs are relative to *https://lnfoot-api.hublots.co*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createCategory**](CategoryControllerApi.md#createcategory) | **POST** /api/categories | 
[**deleteCategory**](CategoryControllerApi.md#deletecategory) | **DELETE** /api/categories/{id} | 
[**getAllCategories**](CategoryControllerApi.md#getallcategories) | **GET** /api/categories | 
[**getCategoryById**](CategoryControllerApi.md#getcategorybyid) | **GET** /api/categories/{id} | 
[**updateCategory**](CategoryControllerApi.md#updatecategory) | **PUT** /api/categories/{id} | 


# **createCategory**
> CategoryDto createCategory(categoryDto)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryControllerApi();
final categoryDto = CategoryDto(); // CategoryDto | 

try {
    final result = api_instance.createCategory(categoryDto);
    print(result);
} catch (e) {
    print('Exception when calling CategoryControllerApi->createCategory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryDto** | [**CategoryDto**](CategoryDto.md)|  | 

### Return type

[**CategoryDto**](CategoryDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteCategory**
> deleteCategory(id)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteCategory(id);
} catch (e) {
    print('Exception when calling CategoryControllerApi->deleteCategory: $e\n');
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

# **getAllCategories**
> List<CategoryDto> getAllCategories()



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryControllerApi();

try {
    final result = api_instance.getAllCategories();
    print(result);
} catch (e) {
    print('Exception when calling CategoryControllerApi->getAllCategories: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<CategoryDto>**](CategoryDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCategoryById**
> CategoryDto getCategoryById(id)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getCategoryById(id);
    print(result);
} catch (e) {
    print('Exception when calling CategoryControllerApi->getCategoryById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**CategoryDto**](CategoryDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCategory**
> CategoryDto updateCategory(id, categoryDto)



### Example
```dart
import 'package:lnfoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryControllerApi();
final id = id_example; // String | 
final categoryDto = CategoryDto(); // CategoryDto | 

try {
    final result = api_instance.updateCategory(id, categoryDto);
    print(result);
} catch (e) {
    print('Exception when calling CategoryControllerApi->updateCategory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **categoryDto** | [**CategoryDto**](CategoryDto.md)|  | 

### Return type

[**CategoryDto**](CategoryDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

