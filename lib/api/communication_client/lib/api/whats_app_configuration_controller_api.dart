//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class WhatsAppConfigurationControllerApi {
  WhatsAppConfigurationControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /api/wsapicontroller/checkwaapistatusandnotifyusers/{branchCode}/{branchName}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [String] branchName (required):
  ///
  /// * [List<String>] fcmTokens (required):
  Future<Response> checkWaApiStatusAndNotifyUsersWithHttpInfo(String branchCode, String branchName, List<String> fcmTokens,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/checkwaapistatusandnotifyusers/{branchCode}/{branchName}'
      .replaceAll('{branchCode}', branchCode)
      .replaceAll('{branchName}', branchName);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('multi', 'fcmTokens', fcmTokens));

    const contentTypes = <String>[];


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
  /// * [String] branchName (required):
  ///
  /// * [List<String>] fcmTokens (required):
  Future<void> checkWaApiStatusAndNotifyUsers(String branchCode, String branchName, List<String> fcmTokens,) async {
    final response = await checkWaApiStatusAndNotifyUsersWithHttpInfo(branchCode, branchName, fcmTokens,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/wsapicontroller/createconf/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> createConfWaApiWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/createconf/{branchCode}'
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
  Future<WhatsAppConfigurationDTO?> createConfWaApi(String branchCode,) async {
    final response = await createConfWaApiWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WhatsAppConfigurationDTO',) as WhatsAppConfigurationDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /api/wsapicontroller/deleteConf/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> deleteConfWaApiWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/deleteConf/{branchCode}'
      .replaceAll('{branchCode}', branchCode);

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
  Future<WhatsAppConfigurationDTO?> deleteConfWaApi(String branchCode,) async {
    final response = await deleteConfWaApiWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WhatsAppConfigurationDTO',) as WhatsAppConfigurationDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/wsapicontroller/fetchallmessages/{branchCode}/{chatNum}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [int] chatNum (required):
  Future<Response> fetchAllMessagesWithHttpInfo(String branchCode, int chatNum,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/fetchallmessages/{branchCode}/{chatNum}'
      .replaceAll('{branchCode}', branchCode)
      .replaceAll('{chatNum}', chatNum.toString());

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
  ///
  /// * [int] chatNum (required):
  Future<List<AllChatListDataDTO>?> fetchAllMessages(String branchCode, int chatNum,) async {
    final response = await fetchAllMessagesWithHttpInfo(branchCode, chatNum,);
    if (response.statusCode >= HttpStatus.badRequest) {
      print('Trimone');
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      print('Trimone2');
      final responseBody = await _decodeBodyBytes(response);
      print('Trimone4');
      return (await apiClient.deserializeAsync(responseBody, 'List<AllChatListDataDTO>') as List)
        .cast<AllChatListDataDTO>()
        .toList(growable: false);

    }
    return null;
  }

  /// Performs an HTTP 'GET /api/wsapicontroller/fetchmessages/{branchCode}/{userPhone}/{messageNum}/{fetchMedia}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [String] userPhone (required):
  ///
  /// * [String] messageNum (required):
  ///
  /// * [bool] fetchMedia (required):
  Future<Response> fetchMessagesWithHttpInfo(String branchCode, String userPhone, String messageNum, bool fetchMedia,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/fetchmessages/{branchCode}/{userPhone}/{messageNum}/{fetchMedia}'
      .replaceAll('{branchCode}', branchCode)
      .replaceAll('{userPhone}', userPhone)
      .replaceAll('{messageNum}', messageNum)
      .replaceAll('{fetchMedia}', fetchMedia.toString());

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
  ///
  /// * [String] userPhone (required):
  ///
  /// * [String] messageNum (required):
  ///
  /// * [bool] fetchMedia (required):
  Future<ChatMessagesResponseDTO?> fetchMessages(String branchCode, String userPhone, String messageNum, bool fetchMedia,) async {
    final response = await fetchMessagesWithHttpInfo(branchCode, userPhone, messageNum, fetchMedia,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChatMessagesResponseDTO',) as ChatMessagesResponseDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/wsapicontroller/retrieveqr/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> retrieveQrWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/retrieveqr/{branchCode}'
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
  Future<WhatsAppConfigurationDTO?> retrieveQr(String branchCode,) async {
    final response = await retrieveQrWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WhatsAppConfigurationDTO',) as WhatsAppConfigurationDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/wsapicontroller/retrieveuserphoto/{branchCode}/{userPhone}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [String] userPhone (required):
  Future<Response> retrieveUserPhotoWithHttpInfo(String branchCode, String userPhone,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/retrieveuserphoto/{branchCode}/{userPhone}'
      .replaceAll('{branchCode}', branchCode)
      .replaceAll('{userPhone}', userPhone);

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
  ///
  /// * [String] userPhone (required):
  Future<String?> retrieveUserPhoto(String branchCode, String userPhone,) async {
    final response = await retrieveUserPhotoWithHttpInfo(branchCode, userPhone,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'String',) as String;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/wsapicontroller/retrieve/waconfstatus/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  Future<Response> retrieveWaApiConfStatusWithHttpInfo(String branchCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/retrieve/waconfstatus/{branchCode}'
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
  Future<WhatsAppConfigurationDTO?> retrieveWaApiConfStatus(String branchCode,) async {
    final response = await retrieveWaApiConfStatusWithHttpInfo(branchCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WhatsAppConfigurationDTO',) as WhatsAppConfigurationDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/wsapicontroller/sendmessage/{branchCode}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] branchCode (required):
  ///
  /// * [String] message (required):
  ///
  /// * [String] number (required):
  Future<Response> sendMessageWithHttpInfo(String branchCode, String message, String number,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/wsapicontroller/sendmessage/{branchCode}'
      .replaceAll('{branchCode}', branchCode);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'message', message));
      queryParams.addAll(_queryParams('', 'number', number));

    const contentTypes = <String>[];


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
  /// * [String] message (required):
  ///
  /// * [String] number (required):
  Future<String?> sendMessage(String branchCode, String message, String number,) async {
    final response = await sendMessageWithHttpInfo(branchCode, message, number,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'String',) as String;
    
    }
    return null;
  }
}
