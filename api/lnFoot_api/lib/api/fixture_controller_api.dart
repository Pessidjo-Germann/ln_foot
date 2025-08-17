//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class FixtureControllerApi {
  FixtureControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /api/v1/fixtures' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CreateFixtureDto] createFixtureDto (required):
  Future<Response> createFixtureWithHttpInfo(CreateFixtureDto createFixtureDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/fixtures';

    // ignore: prefer_final_locals
    Object? postBody = createFixtureDto;

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
  /// * [CreateFixtureDto] createFixtureDto (required):
  Future<FixtureDto?> createFixture(CreateFixtureDto createFixtureDto,) async {
    final response = await createFixtureWithHttpInfo(createFixtureDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FixtureDto',) as FixtureDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /api/v1/fixtures/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteFixtureWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/fixtures/{id}'
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
  Future<void> deleteFixture(String id,) async {
    final response = await deleteFixtureWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/v1/fixtures/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> findFixtureByIdWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/fixtures/{id}'
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
  Future<FixtureDto?> findFixtureById(String id,) async {
    final response = await findFixtureByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FixtureDto',) as FixtureDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/v1/fixtures/by-date' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DateTime] date (required):
  ///
  /// * [String] leagueId:
  Future<Response> getFixturesByDateWithHttpInfo(DateTime date, { String? leagueId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/fixtures/by-date';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'date', date));
    if (leagueId != null) {
      queryParams.addAll(_queryParams('', 'leagueId', leagueId));
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
  /// * [DateTime] date (required):
  ///
  /// * [String] leagueId:
  Future<List<FixtureDto>?> getFixturesByDate(DateTime date, { String? leagueId, }) async {
    final response = await getFixturesByDateWithHttpInfo(date,  leagueId: leagueId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<FixtureDto>') as List)
        .cast<FixtureDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'GET /api/v1/fixtures/upcoming' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] days:
  ///
  /// * [String] leagueId:
  Future<Response> getUpcomingFixturesWithHttpInfo({ int? days, String? leagueId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/fixtures/upcoming';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (days != null) {
      queryParams.addAll(_queryParams('', 'days', days));
    }
    if (leagueId != null) {
      queryParams.addAll(_queryParams('', 'leagueId', leagueId));
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
  /// * [int] days:
  ///
  /// * [String] leagueId:
  Future<List<FixtureDto>?> getUpcomingFixtures({ int? days, String? leagueId, }) async {
    final response = await getUpcomingFixturesWithHttpInfo( days: days, leagueId: leagueId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<FixtureDto>') as List)
        .cast<FixtureDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'GET /api/v1/fixtures' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Pageable] pageable (required):
  ///
  /// * [String] leagueApiId:
  Future<Response> listFixturesWithHttpInfo(Pageable pageable, { String? leagueApiId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/fixtures';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (leagueApiId != null) {
      queryParams.addAll(_queryParams('', 'leagueApiId', leagueApiId));
    }
      queryParams.addAll(_queryParams('', 'pageable', pageable));

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
  /// * [Pageable] pageable (required):
  ///
  /// * [String] leagueApiId:
  Future<PageFixtureDto?> listFixtures(Pageable pageable, { String? leagueApiId, }) async {
    final response = await listFixturesWithHttpInfo(pageable,  leagueApiId: leagueApiId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PageFixtureDto',) as PageFixtureDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/v1/fixtures/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UpdateFixtureDto] updateFixtureDto (required):
  Future<Response> updateFixtureWithHttpInfo(String id, UpdateFixtureDto updateFixtureDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/fixtures/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = updateFixtureDto;

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
  /// * [UpdateFixtureDto] updateFixtureDto (required):
  Future<FixtureDto?> updateFixture(String id, UpdateFixtureDto updateFixtureDto,) async {
    final response = await updateFixtureWithHttpInfo(id, updateFixtureDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FixtureDto',) as FixtureDto;
    
    }
    return null;
  }
}
