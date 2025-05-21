# openapi.api.OrderControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://lnfoot-api.hublots.co*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOrder**](OrderControllerApi.md#createorder) | **POST** /api/orders | 
[**deleteOrder**](OrderControllerApi.md#deleteorder) | **DELETE** /api/orders/{id} | 
[**getAllOrders**](OrderControllerApi.md#getallorders) | **GET** /api/orders | 
[**getOrderById**](OrderControllerApi.md#getorderbyid) | **GET** /api/orders/{id} | 
[**getUserOrders**](OrderControllerApi.md#getuserorders) | **GET** /api/orders/me | 
[**updateOrder**](OrderControllerApi.md#updateorder) | **PUT** /api/orders/{id} | 


# **createOrder**
> OrderDto createOrder(orderDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OrderControllerApi();
final orderDto = OrderDto(); // OrderDto | 

try {
    final result = api_instance.createOrder(orderDto);
    print(result);
} catch (e) {
    print('Exception when calling OrderControllerApi->createOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderDto** | [**OrderDto**](OrderDto.md)|  | 

### Return type

[**OrderDto**](OrderDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOrder**
> deleteOrder(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OrderControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteOrder(id);
} catch (e) {
    print('Exception when calling OrderControllerApi->deleteOrder: $e\n');
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

# **getAllOrders**
> List<OrderDto> getAllOrders(userId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OrderControllerApi();
final userId = userId_example; // String | 

try {
    final result = api_instance.getAllOrders(userId);
    print(result);
} catch (e) {
    print('Exception when calling OrderControllerApi->getAllOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**List<OrderDto>**](OrderDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrderById**
> OrderDto getOrderById(id)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OrderControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getOrderById(id);
    print(result);
} catch (e) {
    print('Exception when calling OrderControllerApi->getOrderById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**OrderDto**](OrderDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserOrders**
> List<OrderDto> getUserOrders(userId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OrderControllerApi();
final userId = userId_example; // String | 

try {
    final result = api_instance.getUserOrders(userId);
    print(result);
} catch (e) {
    print('Exception when calling OrderControllerApi->getUserOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**List<OrderDto>**](OrderDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOrder**
> OrderDto updateOrder(id, orderDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OrderControllerApi();
final id = id_example; // String | 
final orderDto = OrderDto(); // OrderDto | 

try {
    final result = api_instance.updateOrder(id, orderDto);
    print(result);
} catch (e) {
    print('Exception when calling OrderControllerApi->updateOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **orderDto** | [**OrderDto**](OrderDto.md)|  | 

### Return type

[**OrderDto**](OrderDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

