# lnFoot_api.api.ProductControllerApi

## Load the API package
```dart
import 'package:lnFoot_api/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createProduct**](ProductControllerApi.md#createproduct) | **POST** /api/products | 
[**deleteProduct**](ProductControllerApi.md#deleteproduct) | **DELETE** /api/products/{id} | 
[**getAllProducts**](ProductControllerApi.md#getallproducts) | **GET** /api/products | 
[**getProductById**](ProductControllerApi.md#getproductbyid) | **GET** /api/products/{id} | 
[**updateProduct**](ProductControllerApi.md#updateproduct) | **PUT** /api/products/{id} | 


# **createProduct**
> ProductDto createProduct(price, id, imageUrl, file, name, description, stockQuantity, categoryNames, sizes)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductControllerApi();
final price = 8.14; // num | 
final id = id_example; // String | 
final imageUrl = imageUrl_example; // String | 
final file = BINARY_DATA_HERE; // MultipartFile | 
final name = name_example; // String | 
final description = description_example; // String | 
final stockQuantity = 56; // int | 
final categoryNames = []; // List<String> | 
final sizes = []; // List<String> | 

try {
    final result = api_instance.createProduct(price, id, imageUrl, file, name, description, stockQuantity, categoryNames, sizes);
    print(result);
} catch (e) {
    print('Exception when calling ProductControllerApi->createProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **price** | **num**|  | 
 **id** | **String**|  | [optional] 
 **imageUrl** | **String**|  | [optional] 
 **file** | **MultipartFile**|  | [optional] 
 **name** | **String**|  | [optional] 
 **description** | **String**|  | [optional] 
 **stockQuantity** | **int**|  | [optional] 
 **categoryNames** | [**List<String>**](String.md)|  | [optional] 
 **sizes** | [**List<String>**](String.md)|  | [optional] 

### Return type

[**ProductDto**](ProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteProduct**
> deleteProduct(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteProduct(id);
} catch (e) {
    print('Exception when calling ProductControllerApi->deleteProduct: $e\n');
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

# **getAllProducts**
> List<ProductDto> getAllProducts()



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductControllerApi();

try {
    final result = api_instance.getAllProducts();
    print(result);
} catch (e) {
    print('Exception when calling ProductControllerApi->getAllProducts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ProductDto>**](ProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductById**
> ProductDto getProductById(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getProductById(id);
    print(result);
} catch (e) {
    print('Exception when calling ProductControllerApi->getProductById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ProductDto**](ProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProduct**
> ProductDto updateProduct(id, productDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProductControllerApi();
final id = id_example; // String | 
final productDto = ProductDto(); // ProductDto | 

try {
    final result = api_instance.updateProduct(id, productDto);
    print(result);
} catch (e) {
    print('Exception when calling ProductControllerApi->updateProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **productDto** | [**ProductDto**](ProductDto.md)|  | [optional] 

### Return type

[**ProductDto**](ProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

