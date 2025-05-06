# lnFoot_api.api.ColoredProductControllerApi

## Load the API package
```dart
import 'package:lnFoot_api/api.dart';
```

All URIs are relative to *http://lnfoot-api.hublots.co*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createColoredProduct**](ColoredProductControllerApi.md#createcoloredproduct) | **POST** /api/colored-products | 
[**deleteColoredProduct**](ColoredProductControllerApi.md#deletecoloredproduct) | **DELETE** /api/colored-products/{id} | 
[**getColoredProduct**](ColoredProductControllerApi.md#getcoloredproduct) | **GET** /api/colored-products/{id} | 
[**getColoredProducts**](ColoredProductControllerApi.md#getcoloredproducts) | **GET** /api/colored-products | 
[**updateColoredProduct**](ColoredProductControllerApi.md#updatecoloredproduct) | **PUT** /api/colored-products/{id} | 


# **createColoredProduct**
> ColoredProductDto createColoredProduct(coloredProductDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ColoredProductControllerApi();
final coloredProductDto = ColoredProductDto(); // ColoredProductDto | 

try {
    final result = api_instance.createColoredProduct(coloredProductDto);
    print(result);
} catch (e) {
    print('Exception when calling ColoredProductControllerApi->createColoredProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **coloredProductDto** | [**ColoredProductDto**](ColoredProductDto.md)|  | [optional] 

### Return type

[**ColoredProductDto**](ColoredProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteColoredProduct**
> deleteColoredProduct(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ColoredProductControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteColoredProduct(id);
} catch (e) {
    print('Exception when calling ColoredProductControllerApi->deleteColoredProduct: $e\n');
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

# **getColoredProduct**
> ColoredProductDto getColoredProduct(id)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ColoredProductControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getColoredProduct(id);
    print(result);
} catch (e) {
    print('Exception when calling ColoredProductControllerApi->getColoredProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ColoredProductDto**](ColoredProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getColoredProducts**
> List<ColoredProductDto> getColoredProducts()



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ColoredProductControllerApi();

try {
    final result = api_instance.getColoredProducts();
    print(result);
} catch (e) {
    print('Exception when calling ColoredProductControllerApi->getColoredProducts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ColoredProductDto>**](ColoredProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateColoredProduct**
> ColoredProductDto updateColoredProduct(id, coloredProductDto)



### Example
```dart
import 'package:lnFoot_api/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ColoredProductControllerApi();
final id = id_example; // String | 
final coloredProductDto = ColoredProductDto(); // ColoredProductDto | 

try {
    final result = api_instance.updateColoredProduct(id, coloredProductDto);
    print(result);
} catch (e) {
    print('Exception when calling ColoredProductControllerApi->updateColoredProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **coloredProductDto** | [**ColoredProductDto**](ColoredProductDto.md)|  | [optional] 

### Return type

[**ColoredProductDto**](ColoredProductDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

