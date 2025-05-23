//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PromotionProductControllerApi {
  PromotionProductControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /api/promotion-products' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PromotionProductDto] promotionProductDto (required):
  Future<Response> createPromotionProductWithHttpInfo(
    PromotionProductDto promotionProductDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/promotion-products';

    // ignore: prefer_final_locals
    Object? postBody = promotionProductDto;

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
  /// * [PromotionProductDto] promotionProductDto (required):
  Future<PromotionProductDto?> createPromotionProduct(
    PromotionProductDto promotionProductDto,
  ) async {
    final response = await createPromotionProductWithHttpInfo(
      promotionProductDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'PromotionProductDto',
      ) as PromotionProductDto;
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/promotion-products/batch' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [List<PromotionProductDto>] promotionProductDto (required):
  Future<Response> createPromotionProductsWithHttpInfo(
    List<PromotionProductDto> promotionProductDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/promotion-products/batch';

    // ignore: prefer_final_locals
    Object? postBody = promotionProductDto;

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
  /// * [List<PromotionProductDto>] promotionProductDto (required):
  Future<List<PromotionProductDto>?> createPromotionProducts(
    List<PromotionProductDto> promotionProductDto,
  ) async {
    final response = await createPromotionProductsWithHttpInfo(
      promotionProductDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<PromotionProductDto>') as List)
          .cast<PromotionProductDto>()
          .toList(growable: false);
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /api/promotion-products/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deletePromotionProductWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/promotion-products/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

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
  /// * [String] id (required):
  Future<void> deletePromotionProduct(
    String id,
  ) async {
    final response = await deletePromotionProductWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/promotion-products' operation and returns the [Response].
  Future<Response> getAllPromotionProductsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/promotion-products';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<List<PromotionProductDto>?> getAllPromotionProducts() async {
    final response = await getAllPromotionProductsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<PromotionProductDto>') as List)
          .cast<PromotionProductDto>()
          .toList(growable: false);
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/promotion-products/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getPromotionProductByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/promotion-products/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] id (required):
  Future<PromotionProductDto?> getPromotionProductById(
    String id,
  ) async {
    final response = await getPromotionProductByIdWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'PromotionProductDto',
      ) as PromotionProductDto;
    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/promotion-products/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PromotionProductDto] promotionProductDto (required):
  Future<Response> updatePromotionProductWithHttpInfo(
    String id,
    PromotionProductDto promotionProductDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/promotion-products/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = promotionProductDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PromotionProductDto] promotionProductDto (required):
  Future<PromotionProductDto?> updatePromotionProduct(
    String id,
    PromotionProductDto promotionProductDto,
  ) async {
    final response = await updatePromotionProductWithHttpInfo(
      id,
      promotionProductDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'PromotionProductDto',
      ) as PromotionProductDto;
    }
    return null;
  }
}
