# ventimetri_api_communication.api.PushNotificationControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_communication/api.dart';
```

All URIs are relative to *http://192.168.1.4:61360/communicationservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**sendMessage1**](PushNotificationControllerApi.md#sendmessage1) | **POST** /api/pushnotification/sendmessage | 


# **sendMessage1**
> sendMessage1(phoneNumber, titleMessage, message, fcmToken, redirectPage, bookingId)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = PushNotificationControllerApi();
final phoneNumber = phoneNumber_example; // String | 
final titleMessage = titleMessage_example; // String | 
final message = message_example; // String | 
final fcmToken = fcmToken_example; // String | 
final redirectPage = redirectPage_example; // String | 
final bookingId = bookingId_example; // String | 

try {
    api_instance.sendMessage1(phoneNumber, titleMessage, message, fcmToken, redirectPage, bookingId);
} catch (e) {
    print('Exception when calling PushNotificationControllerApi->sendMessage1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **phoneNumber** | **String**|  | 
 **titleMessage** | **String**|  | 
 **message** | **String**|  | 
 **fcmToken** | **String**|  | 
 **redirectPage** | **String**|  | 
 **bookingId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

