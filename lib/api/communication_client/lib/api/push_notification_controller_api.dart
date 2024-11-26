//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PushNotificationControllerApi {
  PushNotificationControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /api/pushnotification/sendmessage' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] phoneNumber (required):
  ///
  /// * [String] titleMessage (required):
  ///
  /// * [String] message (required):
  ///
  /// * [String] fcmToken (required):
  ///
  /// * [String] redirectPage (required):
  ///
  /// * [String] bookingId (required):
  Future<Response> sendMessage1WithHttpInfo(String phoneNumber, String titleMessage, String message, String fcmToken, String redirectPage, String bookingId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/pushnotification/sendmessage';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'phoneNumber', phoneNumber));
      queryParams.addAll(_queryParams('', 'titleMessage', titleMessage));
      queryParams.addAll(_queryParams('', 'message', message));
      queryParams.addAll(_queryParams('', 'fcmToken', fcmToken));
      queryParams.addAll(_queryParams('', 'redirectPage', redirectPage));
      queryParams.addAll(_queryParams('', 'bookingId', bookingId));

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
  /// * [String] phoneNumber (required):
  ///
  /// * [String] titleMessage (required):
  ///
  /// * [String] message (required):
  ///
  /// * [String] fcmToken (required):
  ///
  /// * [String] redirectPage (required):
  ///
  /// * [String] bookingId (required):
  Future<void> sendMessage1(String phoneNumber, String titleMessage, String message, String fcmToken, String redirectPage, String bookingId,) async {
    final response = await sendMessage1WithHttpInfo(phoneNumber, titleMessage, message, fcmToken, redirectPage, bookingId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
