# openapi.api.UploadControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.ln-foot.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteImage**](UploadControllerApi.md#deleteimage) | **DELETE** /api/v1/upload/image | 
[**getImagePresignedUrl**](UploadControllerApi.md#getimagepresignedurl) | **POST** /api/v1/upload/image-presigned-url | 


# **deleteImage**
> deleteImage(deleteImageDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UploadControllerApi();
final deleteImageDto = DeleteImageDto(); // DeleteImageDto | 

try {
    api_instance.deleteImage(deleteImageDto);
} catch (e) {
    print('Exception when calling UploadControllerApi->deleteImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteImageDto** | [**DeleteImageDto**](DeleteImageDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getImagePresignedUrl**
> ImagePresignedUrlResponseDto getImagePresignedUrl(imagePresignedUrlRequestDto)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: keycloak
//defaultApiClient.getAuthentication<OAuth>('keycloak').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UploadControllerApi();
final imagePresignedUrlRequestDto = ImagePresignedUrlRequestDto(); // ImagePresignedUrlRequestDto | 

try {
    final result = api_instance.getImagePresignedUrl(imagePresignedUrlRequestDto);
    print(result);
} catch (e) {
    print('Exception when calling UploadControllerApi->getImagePresignedUrl: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **imagePresignedUrlRequestDto** | [**ImagePresignedUrlRequestDto**](ImagePresignedUrlRequestDto.md)|  | 

### Return type

[**ImagePresignedUrlResponseDto**](ImagePresignedUrlResponseDto.md)

### Authorization

[keycloak](../README.md#keycloak)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

