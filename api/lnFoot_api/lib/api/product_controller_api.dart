//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductControllerApi {
  ProductControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /api/products' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [num] price (required):
  ///
  /// * [List<String>] categoryNames (required):
  ///
  /// * [String] id:
  ///
  /// * [String] imageUrl:
  ///
  /// * [MultipartFile] file:
  ///
  /// * [String] name:
  ///
  /// * [String] description:
  ///
  /// * [int] stockQuantity:
  ///
  /// * [List<String>] sizes:
  Future<Response> createProductWithHttpInfo(
    num price,
    List<String> categoryNames, {
    String? id,
    String? imageUrl,
    MultipartFile? file,
    String? name,
    String? description,
    int? stockQuantity,
    List<String>? sizes,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/products';

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
    if (name != null) {
      hasFields = true;
      mp.fields[r'name'] = parameterToString(name);
    }
    if (description != null) {
      hasFields = true;
      mp.fields[r'description'] = parameterToString(description);
    }
    if (price != null) {
      hasFields = true;
      mp.fields[r'price'] = parameterToString(price);
    }
    if (stockQuantity != null) {
      hasFields = true;
      mp.fields[r'stockQuantity'] = parameterToString(stockQuantity);
    }
    if (categoryNames != null) {
      hasFields = true;
      mp.fields[r'categoryNames'] = parameterToString(categoryNames);
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
  /// * [List<String>] categoryNames (required):
  ///
  /// * [String] id:
  ///
  /// * [String] imageUrl:
  ///
  /// * [MultipartFile] file:
  ///
  /// * [String] name:
  ///
  /// * [String] description:
  ///
  /// * [int] stockQuantity:
  ///
  /// * [List<String>] sizes:
  Future<ProductDto?> createProduct(
    num price,
    List<String> categoryNames, {
    String? id,
    String? imageUrl,
    MultipartFile? file,
    String? name,
    String? description,
    int? stockQuantity,
    List<String>? sizes,
  }) async {
    final response = await createProductWithHttpInfo(
      price,
      categoryNames,
      id: id,
      imageUrl: imageUrl,
      file: file,
      name: name,
      description: description,
      stockQuantity: stockQuantity,
      sizes: sizes,
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
        'ProductDto',
      ) as ProductDto;
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /api/products/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteProductWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/products/{id}'.replaceAll('{id}', id);

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
  Future<void> deleteProduct(
    String id,
  ) async {
    final response = await deleteProductWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/products' operation and returns the [Response].
  Future<Response> getAllProductsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/products';

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

  Future<List<ProductDto>?> getAllProducts() async {
    final response = await getAllProductsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ProductDto>')
              as List)
          .cast<ProductDto>()
          .toList(growable: false);
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/products/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getProductByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/products/{id}'.replaceAll('{id}', id);

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
  Future<ProductDto?> getProductById(
    String id,
  ) async {
    final response = await getProductByIdWithHttpInfo(
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
        'ProductDto',
      ) as ProductDto;
    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/products/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ProductDto] productDto:
  Future<Response> updateProductWithHttpInfo(
    String id, {
    ProductDto? productDto,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/products/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = productDto;

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
  /// * [ProductDto] productDto:
  Future<ProductDto?> updateProduct(
    String id, {
    ProductDto? productDto,
  }) async {
    final response = await updateProductWithHttpInfo(
      id,
      productDto: productDto,
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
        'ProductDto',
      ) as ProductDto;
    }
    return null;
  }
}
