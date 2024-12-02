# ventimetri_api_communication.api.CentralinoApiControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_communication/api.dart';
```

All URIs are relative to *http://192.168.1.4:61360/communicationservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**manageCentralinoCall**](CentralinoApiControllerApi.md#managecentralinocall) | **GET** /api/pro20 | 


# **manageCentralinoCall**
> manageCentralinoCall(key, callerid, calledid, uniqueid, remark, remark2, remark3)



### Example
```dart
import 'package:ventimetri_api_communication/api.dart';

final api_instance = CentralinoApiControllerApi();
final key = key_example; // String | 
final callerid = callerid_example; // String | 
final calledid = calledid_example; // String | 
final uniqueid = uniqueid_example; // String | 
final remark = remark_example; // String | 
final remark2 = remark2_example; // String | 
final remark3 = remark3_example; // String | 

try {
    api_instance.manageCentralinoCall(key, callerid, calledid, uniqueid, remark, remark2, remark3);
} catch (e) {
    print('Exception when calling CentralinoApiControllerApi->manageCentralinoCall: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 
 **callerid** | **String**|  | 
 **calledid** | **String**|  | 
 **uniqueid** | **String**|  | 
 **remark** | **String**|  | [optional] 
 **remark2** | **String**|  | [optional] 
 **remark3** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

