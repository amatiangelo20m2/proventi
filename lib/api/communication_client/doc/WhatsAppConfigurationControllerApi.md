# ventimetri_api_communication.api.WhatsAppConfigurationControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_communication/api.dart';
```

All URIs are relative to *http://192.168.1.4:35005/communicationservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkWaApiStatusAndNotifyUsers**](WhatsAppConfigurationControllerApi.md#checkwaapistatusandnotifyusers) | **POST** /api/wsapicontroller/checkwaapistatusandnotifyusers/{branchCode}/{branchName} | 
[**createConfWaApi**](WhatsAppConfigurationControllerApi.md#createconfwaapi) | **GET** /api/wsapicontroller/createconf/{branchCode} | 
[**deleteConfWaApi**](WhatsAppConfigurationControllerApi.md#deleteconfwaapi) | **DELETE** /api/wsapicontroller/deleteConf/{branchCode} | 
[**fetchAllMessages**](WhatsAppConfigurationControllerApi.md#fetchallmessages) | **GET** /api/wsapicontroller/fetchallmessages/{branchCode}/{chatNum} | 
[**fetchMessages**](WhatsAppConfigurationControllerApi.md#fetchmessages) | **GET** /api/wsapicontroller/fetchmessages/{branchCode}/{userPhone}/{messageNum}/{fetchMedia} | 
[**retrieveQr**](WhatsAppConfigurationControllerApi.md#retrieveqr) | **GET** /api/wsapicontroller/retrieveqr/{branchCode} | 
[**retrieveUserPhoto**](WhatsAppConfigurationControllerApi.md#retrieveuserphoto) | **GET** /api/wsapicontroller/retrieveuserphoto/{branchCode}/{userPhone} | 
[**retrieveWaApiConfStatus**](WhatsAppConfigurationControllerApi.md#retrievewaapiconfstatus) | **GET** /api/wsapicontroller/retrieve/waconfstatus/{branchCode} | 
[**sendMessage**](WhatsAppConfigurationControllerApi.md#sendmessage) | **POST** /api/wsapicontroller/sendmessage/{branchCode} | 


# **checkWaApiStatusAndNotifyUsers**
> checkWaApiStatusAndNotifyUsers(branchCode, branchName, fcmTokens)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 
final branchName = branchName_example; // String | 
final fcmTokens = []; // List<String> | 

try {
    api_instance.checkWaApiStatusAndNotifyUsers(branchCode, branchName, fcmTokens);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->checkWaApiStatusAndNotifyUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **branchName** | **String**|  | 
 **fcmTokens** | [**List<String>**](String.md)|  | [default to const []]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createConfWaApi**
> WhatsAppConfigurationDTO createConfWaApi(branchCode)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.createConfWaApi(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->createConfWaApi: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**WhatsAppConfigurationDTO**](WhatsAppConfigurationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteConfWaApi**
> WhatsAppConfigurationDTO deleteConfWaApi(branchCode)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.deleteConfWaApi(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->deleteConfWaApi: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**WhatsAppConfigurationDTO**](WhatsAppConfigurationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fetchAllMessages**
> List<AllChatListDataDTO> fetchAllMessages(branchCode, chatNum)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 
final chatNum = 56; // int | 

try {
    final result = api_instance.fetchAllMessages(branchCode, chatNum);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->fetchAllMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **chatNum** | **int**|  | 

### Return type

[**List<AllChatListDataDTO>**](AllChatListDataDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fetchMessages**
> ChatMessagesResponseDTO fetchMessages(branchCode, userPhone, messageNum, fetchMedia)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 
final userPhone = userPhone_example; // String | 
final messageNum = messageNum_example; // String | 
final fetchMedia = true; // bool | 

try {
    final result = api_instance.fetchMessages(branchCode, userPhone, messageNum, fetchMedia);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->fetchMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **userPhone** | **String**|  | 
 **messageNum** | **String**|  | 
 **fetchMedia** | **bool**|  | 

### Return type

[**ChatMessagesResponseDTO**](ChatMessagesResponseDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveQr**
> WhatsAppConfigurationDTO retrieveQr(branchCode)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.retrieveQr(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->retrieveQr: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**WhatsAppConfigurationDTO**](WhatsAppConfigurationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveUserPhoto**
> String retrieveUserPhoto(branchCode, userPhone)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 
final userPhone = userPhone_example; // String | 

try {
    final result = api_instance.retrieveUserPhoto(branchCode, userPhone);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->retrieveUserPhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **userPhone** | **String**|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveWaApiConfStatus**
> WhatsAppConfigurationDTO retrieveWaApiConfStatus(branchCode)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.retrieveWaApiConfStatus(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->retrieveWaApiConfStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**WhatsAppConfigurationDTO**](WhatsAppConfigurationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendMessage**
> String sendMessage(branchCode, message, number)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchCode = branchCode_example; // String | 
final message = message_example; // String | 
final number = number_example; // String | 

try {
    final result = api_instance.sendMessage(branchCode, message, number);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->sendMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **message** | **String**|  | 
 **number** | **String**|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

