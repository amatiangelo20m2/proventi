# ventimetri_api_restaurant.api.FloorControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

All URIs are relative to *http://192.168.1.9:33308/restaurantservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createFloorConfiguration**](FloorControllerApi.md#createfloorconfiguration) | **POST** /api/floor/createfloorconfiguration/{branchCode} | 
[**deleteConfiguration**](FloorControllerApi.md#deleteconfiguration) | **DELETE** /api/floor/deletefloorconfiguration/{branchCode}/{floorCode} | 
[**getFloorByBranchCodeAndDate**](FloorControllerApi.md#getfloorbybranchcodeanddate) | **GET** /api/floor/getfloorbybranchcodeanddate/{branchCode} | 
[**updateFloorConfiguration**](FloorControllerApi.md#updatefloorconfiguration) | **PUT** /api/floor/updatefloorconfiguration/{branchCode} | 


# **createFloorConfiguration**
> FloorDTO createFloorConfiguration(branchCode, floorDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 
final floorDTO = FloorDTO(); // FloorDTO | 

try {
    final result = api_instance.createFloorConfiguration(branchCode, floorDTO);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->createFloorConfiguration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **floorDTO** | [**FloorDTO**](FloorDTO.md)|  | 

### Return type

[**FloorDTO**](FloorDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteConfiguration**
> deleteConfiguration(branchCode, floorCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 
final floorCode = floorCode_example; // String | 

try {
    api_instance.deleteConfiguration(branchCode, floorCode);
} catch (e) {
    print('Exception when calling FloorControllerApi->deleteConfiguration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **floorCode** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFloorByBranchCodeAndDate**
> List<FloorDTO> getFloorByBranchCodeAndDate(branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.getFloorByBranchCodeAndDate(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->getFloorByBranchCodeAndDate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**List<FloorDTO>**](FloorDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateFloorConfiguration**
> FloorDTO updateFloorConfiguration(branchCode, floorDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 
final floorDTO = FloorDTO(); // FloorDTO | 

try {
    final result = api_instance.updateFloorConfiguration(branchCode, floorDTO);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->updateFloorConfiguration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **floorDTO** | [**FloorDTO**](FloorDTO.md)|  | 

### Return type

[**FloorDTO**](FloorDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

