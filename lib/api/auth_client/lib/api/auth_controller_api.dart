//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthControllerApi {
  AuthControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'DELETE /api/auth/delete' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] email (required):
  Future<Response> deleteUserByEmailWithHttpInfo(String email,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/delete';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'email', email));

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
  /// * [String] email (required):
  Future<void> deleteUserByEmail(String email,) async {
    final response = await deleteUserByEmailWithHttpInfo(email,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/auth/getfcmtoken' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userCode (required):
  Future<Response> getFcmTokenByUserCodeWithHttpInfo(String userCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/getfcmtoken';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'userCode', userCode));

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
  /// * [String] userCode (required):
  Future<String?> getFcmTokenByUserCode(String userCode,) async {
    final response = await getFcmTokenByUserCodeWithHttpInfo(userCode,);
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

  /// Performs an HTTP 'PUT /api/auth/reset/password' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userCode (required):
  ///
  /// * [String] password (required):
  Future<Response> resetPasswordWithHttpInfo(String userCode, String password,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/reset/password';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'userCode', userCode));
      queryParams.addAll(_queryParams('', 'password', password));

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
  /// * [String] userCode (required):
  ///
  /// * [String] password (required):
  Future<void> resetPassword(String userCode, String password,) async {
    final response = await resetPasswordWithHttpInfo(userCode, password,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /api/auth/retrieve' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] email (required):
  Future<Response> retrieveUserByEmailWithHttpInfo(String email,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/retrieve';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'email', email));

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
  /// * [String] email (required):
  Future<UserResponseEntity?> retrieveUserByEmail(String email,) async {
    final response = await retrieveUserByEmailWithHttpInfo(email,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserResponseEntity',) as UserResponseEntity;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/auth/retrievebyusercode' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userCode (required):
  Future<Response> retrieveUserByUserCodeWithHttpInfo(String userCode,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/retrievebyusercode';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'userCode', userCode));

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
  /// * [String] userCode (required):
  Future<UserResponseEntity?> retrieveUserByUserCode(String userCode,) async {
    final response = await retrieveUserByUserCodeWithHttpInfo(userCode,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserResponseEntity',) as UserResponseEntity;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/auth/sign-in' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Credentials] credentials (required):
  Future<Response> signInWithHttpInfo(Credentials credentials,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/sign-in';

    // ignore: prefer_final_locals
    Object? postBody = credentials;

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
  /// * [Credentials] credentials (required):
  Future<AuthResponseEntity?> signIn(Credentials credentials,) async {
    final response = await signInWithHttpInfo(credentials,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AuthResponseEntity',) as AuthResponseEntity;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/auth/google/sign-in' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Credentials] credentials (required):
  Future<Response> signInWithGoogleWithHttpInfo(Credentials credentials,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/google/sign-in';

    // ignore: prefer_final_locals
    Object? postBody = credentials;

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
  /// * [Credentials] credentials (required):
  Future<AuthResponseEntity?> signInWithGoogle(Credentials credentials,) async {
    final response = await signInWithGoogleWithHttpInfo(credentials,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AuthResponseEntity',) as AuthResponseEntity;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/auth/sign-in-with-token' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [JwtEntity] jwtEntity (required):
  Future<Response> signInWithTokenWithHttpInfo(JwtEntity jwtEntity,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/sign-in-with-token';

    // ignore: prefer_final_locals
    Object? postBody = jwtEntity;

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
  /// * [JwtEntity] jwtEntity (required):
  Future<AuthResponseEntity?> signInWithToken(JwtEntity jwtEntity,) async {
    final response = await signInWithTokenWithHttpInfo(jwtEntity,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AuthResponseEntity',) as AuthResponseEntity;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/auth/sign-in-with-user-code' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [UserCodeCredential] userCodeCredential (required):
  Future<Response> signInWithUserCodeWithHttpInfo(UserCodeCredential userCodeCredential,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/sign-in-with-user-code';

    // ignore: prefer_final_locals
    Object? postBody = userCodeCredential;

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
  /// * [UserCodeCredential] userCodeCredential (required):
  Future<AuthResponseEntity?> signInWithUserCode(UserCodeCredential userCodeCredential,) async {
    final response = await signInWithUserCodeWithHttpInfo(userCodeCredential,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AuthResponseEntity',) as AuthResponseEntity;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/auth/sign-up' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Credentials] credentials (required):
  Future<Response> signUpWithHttpInfo(Credentials credentials,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/sign-up';

    // ignore: prefer_final_locals
    Object? postBody = credentials;

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
  /// * [Credentials] credentials (required):
  Future<AuthResponseEntity?> signUp(Credentials credentials,) async {
    final response = await signUpWithHttpInfo(credentials,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AuthResponseEntity',) as AuthResponseEntity;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /api/auth/update' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [UpdateUserEntity] updateUserEntity (required):
  Future<Response> updateUserWithHttpInfo(UpdateUserEntity updateUserEntity,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/update';

    // ignore: prefer_final_locals
    Object? postBody = updateUserEntity;

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
  /// * [UpdateUserEntity] updateUserEntity (required):
  Future<void> updateUser(UpdateUserEntity updateUserEntity,) async {
    final response = await updateUserWithHttpInfo(updateUserEntity,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
