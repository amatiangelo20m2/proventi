//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class FloorControllerApi {
  FloorControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /api/floor/createfloorconfiguration/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [FloorDTO] floorDTO (required):
  Future<Response> createFloorConfigurationWithHttpInfo(String branchCode, FloorDTO floorDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/createfloorconfiguration/{branchCode}'
      .replaceAll('{branchCode}', branchCode);

    // ignore: prefer_final_locals
    Object? postBody = floorDTO;

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
  /// * [String] branchCode (required):
  ///
  /// * [FloorDTO] floorDTO (required):
  Future<FloorDTO?> createFloorConfiguration(String branchCode, FloorDTO floorDTO,) async {
    final response = await createFloorConfigurationWithHttpInfo(branchCode, floorDTO,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FloorDTO',) as FloorDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /api/floor/deletefloorconfiguration/{branchCode}/{floorCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [String] floorCode (required):
  Future<Response> deleteConfigurationWithHttpInfo(String branchCode, String floorCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/deletefloorconfiguration/{branchCode}/{floorCode}'
      .replaceAll('{branchCode}', branchCode)
      .replaceAll('{floorCode}', floorCode);

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
  /// * [String] branchCode (required):
  ///
  /// * [String] floorCode (required):
  Future<void> deleteConfiguration(String branchCode, String floorCode,) async {
    final response = await deleteConfigurationWithHttpInfo(branchCode, floorCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/floor/getfloorbybranchcodeanddate/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> getFloorByBranchCodeAndDateWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/getfloorbybranchcodeanddate/{branchCode}'
      .replaceAll('{branchCode}', branchCode);

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
  /// * [String] branchCode (required):
  Future<List<FloorDTO>?> getFloorByBranchCodeAndDate(String branchCode,) async {
    final response = await getFloorByBranchCodeAndDateWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<FloorDTO>') as List)
        .cast<FloorDTO>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/floor/updatefloorconfiguration/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [FloorDTO] floorDTO (required):
  Future<Response> updateFloorConfigurationWithHttpInfo(String branchCode, FloorDTO floorDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/updatefloorconfiguration/{branchCode}'
      .replaceAll('{branchCode}', branchCode);

    // ignore: prefer_final_locals
    Object? postBody = floorDTO;

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
  /// * [String] branchCode (required):
  ///
  /// * [FloorDTO] floorDTO (required):
  Future<FloorDTO?> updateFloorConfiguration(String branchCode, FloorDTO floorDTO,) async {
    final response = await updateFloorConfigurationWithHttpInfo(branchCode, floorDTO,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FloorDTO',) as FloorDTO;
    
    }
    return null;
  }
}
