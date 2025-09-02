//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProductVariantControllerApi {
  ProductVariantControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /api/product-variants' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [num] price (required):
  ///
  /// * [String] id:
  ///
  /// * [String] imageUrl:
  ///
  /// * [MultipartFile] file:
  ///
  /// * [String] colorCode:
  ///
  /// * [String] productId:
  ///
  /// * [int] stockQuantity:
  ///
  /// * [List<String>] sizes:
  Future<Response> createProductVariantWithHttpInfo(num price, { String? id, String? imageUrl, MultipartFile? file, String? colorCode, String? productId, int? stockQuantity, List<String>? sizes, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/product-variants';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (id != null) {
      hasFields = true;
      mp.fields[r'id'] = parameterToString(id);
    }
    if (imageUrl != null) {
      hasFields = true;
      mp.fields[r'imageUrl'] = parameterToString(imageUrl);
    }
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (colorCode != null) {
      hasFields = true;
      mp.fields[r'colorCode'] = parameterToString(colorCode);
    }
    if (productId != null) {
      hasFields = true;
      mp.fields[r'productId'] = parameterToString(productId);
    }
    if (price != null) {
      hasFields = true;
      mp.fields[r'price'] = parameterToString(price);
    }
    if (stockQuantity != null) {
      hasFields = true;
      mp.fields[r'stockQuantity'] = parameterToString(stockQuantity);
    }
    if (sizes != null) {
      hasFields = true;
      mp.fields[r'sizes'] = parameterToString(sizes);
    }
    if (hasFields) {
      postBody = mp;
    }

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
  /// * [num] price (required):
  ///
  /// * [String] id:
  ///
  /// * [String] imageUrl:
  ///
  /// * [MultipartFile] file:
  ///
  /// * [String] colorCode:
  ///
  /// * [String] productId:
  ///
  /// * [int] stockQuantity:
  ///
  /// * [List<String>] sizes:
  Future<ProductVariantDto?> createProductVariant(num price, { String? id, String? imageUrl, MultipartFile? file, String? colorCode, String? productId, int? stockQuantity, List<String>? sizes, }) async {
    final response = await createProductVariantWithHttpInfo(price,  id: id, imageUrl: imageUrl, file: file, colorCode: colorCode, productId: productId, stockQuantity: stockQuantity, sizes: sizes, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductVariantDto',) as ProductVariantDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/product-variants/bulk' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [List<ProductVariantDto>] variants (required):
  Future<Response> createProductVariantsWithHttpInfo(List<ProductVariantDto> variants,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/product-variants/bulk';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (variants != null) {
      hasFields = true;
      mp.fields[r'variants'] = parameterToString(variants);
    }
    if (hasFields) {
      postBody = mp;
    }

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
  /// * [List<ProductVariantDto>] variants (required):
  Future<List<ProductVariantDto>?> createProductVariants(List<ProductVariantDto> variants,) async {
    final response = await createProductVariantsWithHttpInfo(variants,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ProductVariantDto>') as List)
        .cast<ProductVariantDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'DELETE /api/product-variants/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteProductVariantWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/product-variants/{id}'
      .replaceAll('{id}', id);

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
  Future<void> deleteProductVariant(String id,) async {
    final response = await deleteProductVariantWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/product-variants/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getProductVariantWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/product-variants/{id}'
      .replaceAll('{id}', id);

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
  Future<ProductVariantDto?> getProductVariant(String id,) async {
    final response = await getProductVariantWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductVariantDto',) as ProductVariantDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/product-variants' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] productId:
  Future<Response> getProductVariantsWithHttpInfo({ String? productId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/product-variants';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (productId != null) {
      queryParams.addAll(_queryParams('', 'productId', productId));
    }

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
  /// * [String] productId:
  Future<List<ProductVariantDto>?> getProductVariants({ String? productId, }) async {
    final response = await getProductVariantsWithHttpInfo( productId: productId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ProductVariantDto>') as List)
        .cast<ProductVariantDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/product-variants/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ProductVariantDto] productVariantDto:
  Future<Response> updateProductVariantWithHttpInfo(String id, { ProductVariantDto? productVariantDto, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/product-variants/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = productVariantDto;

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
  /// * [ProductVariantDto] productVariantDto:
  Future<ProductVariantDto?> updateProductVariant(String id, { ProductVariantDto? productVariantDto, }) async {
    final response = await updateProductVariantWithHttpInfo(id,  productVariantDto: productVariantDto, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductVariantDto',) as ProductVariantDto;
    
    }
    return null;
  }
}
