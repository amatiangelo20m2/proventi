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

  /// Performs an HTTP 'PUT /api/floor/addbookingcalendartotable/{tableCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] tableCode (required):
  ///
  /// * [TableBookingCalendar] tableBookingCalendar (required):
  Future<Response> addBookingCalendarToTableWithHttpInfo(String tableCode, TableBookingCalendar tableBookingCalendar,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/addbookingcalendartotable/{tableCode}'
      .replaceAll('{tableCode}', tableCode);

    // ignore: prefer_final_locals
    Object? postBody = tableBookingCalendar;

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
  /// * [String] tableCode (required):
  ///
  /// * [TableBookingCalendar] tableBookingCalendar (required):
  Future<TableConfDTO?> addBookingCalendarToTable(String tableCode, TableBookingCalendar tableBookingCalendar,) async {
    final response = await addBookingCalendarToTableWithHttpInfo(tableCode, tableBookingCalendar,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TableConfDTO',) as TableConfDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/floor/addtabletofloor/{branchCode}/{floorCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [String] floorCode (required):
  ///
  /// * [TableConfDTO] tableConfDTO (required):
  Future<Response> addTableToFloorWithHttpInfo(String branchCode, String floorCode, TableConfDTO tableConfDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/addtabletofloor/{branchCode}/{floorCode}'
      .replaceAll('{branchCode}', branchCode)
      .replaceAll('{floorCode}', floorCode);

    // ignore: prefer_final_locals
    Object? postBody = tableConfDTO;

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
  /// * [String] floorCode (required):
  ///
  /// * [TableConfDTO] tableConfDTO (required):
  Future<TableConfDTO?> addTableToFloor(String branchCode, String floorCode, TableConfDTO tableConfDTO,) async {
    final response = await addTableToFloorWithHttpInfo(branchCode, floorCode, tableConfDTO,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TableConfDTO',) as TableConfDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/floor/createfloorconfiguration' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FloorDTO] floorDTO (required):
  Future<Response> createFloorConfigurationWithHttpInfo(FloorDTO floorDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/createfloorconfiguration';

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
  /// * [FloorDTO] floorDTO (required):
  Future<FloorDTO?> createFloorConfiguration(FloorDTO floorDTO,) async {
    final response = await createFloorConfigurationWithHttpInfo(floorDTO,);
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
  Future<Response> deleteFloorConfigurationWithHttpInfo(String branchCode, String floorCode,) async {
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
  Future<void> deleteFloorConfiguration(String branchCode, String floorCode,) async {
    final response = await deleteFloorConfigurationWithHttpInfo(branchCode, floorCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /api/floor/deleteTable/{floorCode}/{tableCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] floorCode (required):
  ///
  /// * [String] tableCode (required):
  Future<Response> deleteTableWithHttpInfo(String floorCode, String tableCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/deleteTable/{floorCode}/{tableCode}'
      .replaceAll('{floorCode}', floorCode)
      .replaceAll('{tableCode}', tableCode);

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
  /// * [String] floorCode (required):
  ///
  /// * [String] tableCode (required):
  Future<void> deleteTable(String floorCode, String tableCode,) async {
    final response = await deleteTableWithHttpInfo(floorCode, tableCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/floor/getfloorbybranchcode/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> getFloorByBranchCodeWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/getfloorbybranchcode/{branchCode}'
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
  Future<List<FloorDTO>?> getFloorByBranchCode(String branchCode,) async {
    final response = await getFloorByBranchCodeWithHttpInfo(branchCode,);
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

  /// Performs an HTTP 'GET /api/floor/getfloorbybranchcodeanddate/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [DateTime] zonedDateTime (required):
  Future<Response> getFloorByBranchCodeAndDateWithHttpInfo(String branchCode, DateTime zonedDateTime,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/getfloorbybranchcodeanddate/{branchCode}'
      .replaceAll('{branchCode}', branchCode);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'zonedDateTime', zonedDateTime));

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
  /// * [DateTime] zonedDateTime (required):
  Future<List<FloorDTO>?> getFloorByBranchCodeAndDate(String branchCode, DateTime zonedDateTime,) async {
    final response = await getFloorByBranchCodeAndDateWithHttpInfo(branchCode, zonedDateTime,);
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

  /// Performs an HTTP 'DELETE /api/floor/remvovebookingcalendarfromtable/{tableCode}/{bookingCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] tableCode (required):
  ///
  /// * [String] bookingCode (required):
  Future<Response> removeBookingCalendarFromTableWithHttpInfo(String tableCode, String bookingCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/remvovebookingcalendarfromtable/{tableCode}/{bookingCode}'
      .replaceAll('{tableCode}', tableCode)
      .replaceAll('{bookingCode}', bookingCode);

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
  /// * [String] tableCode (required):
  ///
  /// * [String] bookingCode (required):
  Future<void> removeBookingCalendarFromTable(String tableCode, String bookingCode,) async {
    final response = await removeBookingCalendarFromTableWithHttpInfo(tableCode, bookingCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
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

  /// Performs an HTTP 'PUT /api/floor/updateTable/{tableCode}/{tableName}/{partyNumber}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] tableCode (required):
  ///
  /// * [String] tableName (required):
  ///
  /// * [int] partyNumber (required):
  Future<Response> updateTableWithHttpInfo(String tableCode, String tableName, int partyNumber,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/floor/updateTable/{tableCode}/{tableName}/{partyNumber}'
      .replaceAll('{tableCode}', tableCode)
      .replaceAll('{tableName}', tableName)
      .replaceAll('{partyNumber}', partyNumber.toString());

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
  /// * [String] tableCode (required):
  ///
  /// * [String] tableName (required):
  ///
  /// * [int] partyNumber (required):
  Future<void> updateTable(String tableCode, String tableName, int partyNumber,) async {
    final response = await updateTableWithHttpInfo(tableCode, tableName, partyNumber,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
