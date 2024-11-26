//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CentralinoApiControllerApi {
  CentralinoApiControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /api/pro20' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] key (required):
  ///
  /// * [String] callerid (required):
  ///
  /// * [String] calledid (required):
  ///
  /// * [String] uniqueid (required):
  ///
  /// * [String] remark:
  ///
  /// * [String] remark2:
  ///
  /// * [String] remark3:
  Future<Response> manageCentralinoCallWithHttpInfo(String key, String callerid, String calledid, String uniqueid, { String? remark, String? remark2, String? remark3, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/pro20';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'key', key));
      queryParams.addAll(_queryParams('', 'callerid', callerid));
      queryParams.addAll(_queryParams('', 'calledid', calledid));
      queryParams.addAll(_queryParams('', 'uniqueid', uniqueid));
    if (remark != null) {
      queryParams.addAll(_queryParams('', 'remark', remark));
    }
    if (remark2 != null) {
      queryParams.addAll(_queryParams('', 'remark2', remark2));
    }
    if (remark3 != null) {
      queryParams.addAll(_queryParams('', 'remark3', remark3));
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
  /// * [String] key (required):
  ///
  /// * [String] callerid (required):
  ///
  /// * [String] calledid (required):
  ///
  /// * [String] uniqueid (required):
  ///
  /// * [String] remark:
  ///
  /// * [String] remark2:
  ///
  /// * [String] remark3:
  Future<void> manageCentralinoCall(String key, String callerid, String calledid, String uniqueid, { String? remark, String? remark2, String? remark3, }) async {
    final response = await manageCentralinoCallWithHttpInfo(key, callerid, calledid, uniqueid,  remark: remark, remark2: remark2, remark3: remark3, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
