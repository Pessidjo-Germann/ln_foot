//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UploadControllerApi {
  UploadControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'DELETE /api/v1/upload/image' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DeleteImageDto] deleteImageDto (required):
  Future<Response> deleteImageWithHttpInfo(DeleteImageDto deleteImageDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/upload/image';

    // ignore: prefer_final_locals
    Object? postBody = deleteImageDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [DeleteImageDto] deleteImageDto (required):
  Future<void> deleteImage(DeleteImageDto deleteImageDto,) async {
    final response = await deleteImageWithHttpInfo(deleteImageDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /api/v1/upload/image-presigned-url' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ImagePresignedUrlRequestDto] imagePresignedUrlRequestDto (required):
  Future<Response> getImagePresignedUrlWithHttpInfo(ImagePresignedUrlRequestDto imagePresignedUrlRequestDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/upload/image-presigned-url';

    // ignore: prefer_final_locals
    Object? postBody = imagePresignedUrlRequestDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ImagePresignedUrlRequestDto] imagePresignedUrlRequestDto (required):
  Future<ImagePresignedUrlResponseDto?> getImagePresignedUrl(ImagePresignedUrlRequestDto imagePresignedUrlRequestDto,) async {
    final response = await getImagePresignedUrlWithHttpInfo(imagePresignedUrlRequestDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ImagePresignedUrlResponseDto',) as ImagePresignedUrlResponseDto;
    
    }
    return null;
  }
}
