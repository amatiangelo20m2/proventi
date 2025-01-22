//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CampainControllerApi {
  CampainControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /api/campain/create/{branchCode}/{campainName}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [String] campainName (required):
  ///
  /// * [String] createdBy (required):
  Future<Response> createCampainWithHttpInfo(String branchCode, String campainName, String createdBy,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/campain/create/{branchCode}/{campainName}'
      .replaceAll('{branchCode}', branchCode)
      .replaceAll('{campainName}', campainName);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'createdBy', createdBy));

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
  ///
  /// * [String] campainName (required):
  ///
  /// * [String] createdBy (required):
  Future<SendingCampainDTO?> createCampain(String branchCode, String campainName, String createdBy,) async {
    final response = await createCampainWithHttpInfo(branchCode, campainName, createdBy,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendingCampainDTO',) as SendingCampainDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/campain/retrieve/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> retrieveCampainByBranchCodeWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/campain/retrieve/{branchCode}'
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
  Future<List<SendingCampainDTO>?> retrieveCampainByBranchCode(String branchCode,) async {
    final response = await retrieveCampainByBranchCodeWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<SendingCampainDTO>') as List)
        .cast<SendingCampainDTO>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/campain/startcampain/{campainCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] campainCode (required):
  Future<Response> startWithHttpInfo(String campainCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/campain/startcampain/{campainCode}'
      .replaceAll('{campainCode}', campainCode);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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
  /// * [String] campainCode (required):
  Future<void> start(String campainCode,) async {
    final response = await startWithHttpInfo(campainCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PUT /api/campain/updatecampain' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [SendingCampainDTO] sendingCampainDTO (required):
  Future<Response> updateCampainWithHttpInfo(SendingCampainDTO sendingCampainDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/campain/updatecampain';

    // ignore: prefer_final_locals
    Object? postBody = sendingCampainDTO;

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
  /// * [SendingCampainDTO] sendingCampainDTO (required):
  Future<SendingCampainDTO?> updateCampain(SendingCampainDTO sendingCampainDTO,) async {
    final response = await updateCampainWithHttpInfo(sendingCampainDTO,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendingCampainDTO',) as SendingCampainDTO;
    
    }
    return null;
  }
}
