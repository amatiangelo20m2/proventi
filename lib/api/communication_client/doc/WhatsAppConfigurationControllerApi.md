# ventimetri_api_communication.api.WhatsAppConfigurationControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_communication/api.dart';
```

All URIs are relative to *http://192.168.1.4:5703/communicationservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createConfWaApi**](WhatsAppConfigurationControllerApi.md#createconfwaapi) | **GET** /api/wsapicontroller/createconf/{branchCode} | 
[**deleteConfWaApi**](WhatsAppConfigurationControllerApi.md#deleteconfwaapi) | **DELETE** /api/wsapicontroller/deleteConf/{branchCode} | 
[**retrieveQr**](WhatsAppConfigurationControllerApi.md#retrieveqr) | **GET** /api/wsapicontroller/retrieveqr/{branchCode} | 
[**retrieveUserPhoto**](WhatsAppConfigurationControllerApi.md#retrieveuserphoto) | **GET** /api/wsapicontroller/retrieveuserphoto/{branchcode}/{userphone} | 
[**retrieveWaApiConfStatus**](WhatsAppConfigurationControllerApi.md#retrievewaapiconfstatus) | **GET** /api/wsapicontroller/retrieve/waconfstatus/{branchCode} | 
[**sendMessage**](WhatsAppConfigurationControllerApi.md#sendmessage) | **POST** /api/wsapicontroller/sendmessage/{branchCode} | 


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
> String retrieveUserPhoto(branchcode, userphone)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = WhatsAppConfigurationControllerApi();
final branchcode = branchcode_example; // String | 
final userphone = userphone_example; // String | 

try {
    final result = api_instance.retrieveUserPhoto(branchcode, userphone);
    print(result);
} catch (e) {
    print('Exception when calling WhatsAppConfigurationControllerApi->retrieveUserPhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchcode** | **String**|  | 
 **userphone** | **String**|  | 

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

