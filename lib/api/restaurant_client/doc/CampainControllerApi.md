# ventimetri_api_restaurant.api.CampainControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

All URIs are relative to *http://192.168.1.9:31083/restaurantservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createCampain**](CampainControllerApi.md#createcampain) | **GET** /api/campain/create/{branchCode}/{campainName} | 
[**retrieveCampainByBranchCode**](CampainControllerApi.md#retrievecampainbybranchcode) | **GET** /api/campain/retrieve/{branchCode} | 
[**start**](CampainControllerApi.md#start) | **PUT** /api/campain/startcampain/{campainCode} | 
[**updateCampain**](CampainControllerApi.md#updatecampain) | **PUT** /api/campain/updatecampain | 


# **createCampain**
> SendingCampainDTO createCampain(branchCode, campainName, createdBy)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CampainControllerApi();
final branchCode = branchCode_example; // String | 
final campainName = campainName_example; // String | 
final createdBy = createdBy_example; // String | 

try {
    final result = api_instance.createCampain(branchCode, campainName, createdBy);
    print(result);
} catch (e) {
    print('Exception when calling CampainControllerApi->createCampain: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **campainName** | **String**|  | 
 **createdBy** | **String**|  | 

### Return type

[**SendingCampainDTO**](SendingCampainDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveCampainByBranchCode**
> List<SendingCampainDTO> retrieveCampainByBranchCode(branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CampainControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.retrieveCampainByBranchCode(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling CampainControllerApi->retrieveCampainByBranchCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**List<SendingCampainDTO>**](SendingCampainDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **start**
> start(campainCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CampainControllerApi();
final campainCode = campainCode_example; // String | 

try {
    api_instance.start(campainCode);
} catch (e) {
    print('Exception when calling CampainControllerApi->start: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campainCode** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCampain**
> SendingCampainDTO updateCampain(sendingCampainDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CampainControllerApi();
final sendingCampainDTO = SendingCampainDTO(); // SendingCampainDTO | 

try {
    final result = api_instance.updateCampain(sendingCampainDTO);
    print(result);
} catch (e) {
    print('Exception when calling CampainControllerApi->updateCampain: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendingCampainDTO** | [**SendingCampainDTO**](SendingCampainDTO.md)|  | 

### Return type

[**SendingCampainDTO**](SendingCampainDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

