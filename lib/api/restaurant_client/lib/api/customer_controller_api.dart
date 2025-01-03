//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CustomerControllerApi {
  CustomerControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /api/customer/retrieve/{prefix}/{phoneNumber}/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] prefix (required):
  ///
  /// * [String] phoneNumber (required):
  ///
  /// * [String] branchCode (required):
  Future<Response> findCustomerByPhoneAndPrefixAndBranchCodeWithHttpInfo(String prefix, String phoneNumber, String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/customer/retrieve/{prefix}/{phoneNumber}/{branchCode}'
      .replaceAll('{prefix}', prefix)
      .replaceAll('{phoneNumber}', phoneNumber)
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
  /// * [String] prefix (required):
  ///
  /// * [String] phoneNumber (required):
  ///
  /// * [String] branchCode (required):
  Future<CustomerDTO?> findCustomerByPhoneAndPrefixAndBranchCode(String prefix, String phoneNumber, String branchCode,) async {
    final response = await findCustomerByPhoneAndPrefixAndBranchCodeWithHttpInfo(prefix, phoneNumber, branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CustomerDTO',) as CustomerDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/customer/retrievecustomerhistory/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> retrieveCustomerHistoryByBranchCodeWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/customer/retrievecustomerhistory/{branchCode}'
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
  Future<List<Object>?> retrieveCustomerHistoryByBranchCode(String branchCode,) async {
    final response = await retrieveCustomerHistoryByBranchCodeWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Object>') as List)
        .cast<Object>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'GET /api/customer/retrievehistoricalcustomers/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> retrieveHistoricalCustomersBasedOnReservationsByBranchCodeWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/customer/retrievehistoricalcustomers/{branchCode}'
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
  Future<List<CustomerHistoryDTO>?> retrieveHistoricalCustomersBasedOnReservationsByBranchCode(String branchCode,) async {
    final response = await retrieveHistoricalCustomersBasedOnReservationsByBranchCodeWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<CustomerHistoryDTO>') as List)
        .cast<CustomerHistoryDTO>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'POST /api/customer/save' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CustomerDTO] customerDTO (required):
  Future<Response> saveWithHttpInfo(CustomerDTO customerDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/customer/save';

    // ignore: prefer_final_locals
    Object? postBody = customerDTO;

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
  /// * [CustomerDTO] customerDTO (required):
  Future<CustomerDTO?> save(CustomerDTO customerDTO,) async {
    final response = await saveWithHttpInfo(customerDTO,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CustomerDTO',) as CustomerDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/customer/updatecustomer' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CustomerDTO] customerDTO (required):
  Future<Response> updateCustomerWithHttpInfo(CustomerDTO customerDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/customer/updatecustomer';

    // ignore: prefer_final_locals
    Object? postBody = customerDTO;

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
  /// * [CustomerDTO] customerDTO (required):
  Future<CustomerDTO?> updateCustomer(CustomerDTO customerDTO,) async {
    final response = await updateCustomerWithHttpInfo(customerDTO,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CustomerDTO',) as CustomerDTO;
    
    }
    return null;
  }
}
