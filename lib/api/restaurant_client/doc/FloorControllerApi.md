# ventimetri_api_restaurant.api.FloorControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

All URIs are relative to *http://192.168.1.9:31083/restaurantservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addBookingCalendarToTable**](FloorControllerApi.md#addbookingcalendartotable) | **PUT** /api/floor/addbookingcalendartotable/{tableCode} | 
[**addTableToFloor**](FloorControllerApi.md#addtabletofloor) | **PUT** /api/floor/addtabletofloor/{branchCode}/{floorCode} | 
[**createFloorConfiguration**](FloorControllerApi.md#createfloorconfiguration) | **POST** /api/floor/createfloorconfiguration | 
[**deleteFloorConfiguration**](FloorControllerApi.md#deletefloorconfiguration) | **DELETE** /api/floor/deletefloorconfiguration/{branchCode}/{floorCode} | 
[**deleteTable**](FloorControllerApi.md#deletetable) | **DELETE** /api/floor/deleteTable/{floorCode}/{tableCode} | 
[**getFloorByBranchCode**](FloorControllerApi.md#getfloorbybranchcode) | **GET** /api/floor/getfloorbybranchcode/{branchCode} | 
[**getFloorByBranchCodeAndDate**](FloorControllerApi.md#getfloorbybranchcodeanddate) | **GET** /api/floor/getfloorbybranchcodeanddate/{branchCode} | 
[**removeBookingCalendarFromTable**](FloorControllerApi.md#removebookingcalendarfromtable) | **DELETE** /api/floor/remvovebookingcalendarfromtable/{tableCode}/{bookingCode} | 
[**updateFloorConfiguration**](FloorControllerApi.md#updatefloorconfiguration) | **PUT** /api/floor/updatefloorconfiguration/{branchCode} | 


# **addBookingCalendarToTable**
> TableConfDTO addBookingCalendarToTable(tableCode, tableBookingCalendar)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final tableCode = tableCode_example; // String | 
final tableBookingCalendar = TableBookingCalendar(); // TableBookingCalendar | 

try {
    final result = api_instance.addBookingCalendarToTable(tableCode, tableBookingCalendar);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->addBookingCalendarToTable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tableCode** | **String**|  | 
 **tableBookingCalendar** | [**TableBookingCalendar**](TableBookingCalendar.md)|  | 

### Return type

[**TableConfDTO**](TableConfDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addTableToFloor**
> TableConfDTO addTableToFloor(branchCode, floorCode, tableConfDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 
final floorCode = floorCode_example; // String | 
final tableConfDTO = TableConfDTO(); // TableConfDTO | 

try {
    final result = api_instance.addTableToFloor(branchCode, floorCode, tableConfDTO);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->addTableToFloor: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **floorCode** | **String**|  | 
 **tableConfDTO** | [**TableConfDTO**](TableConfDTO.md)|  | 

### Return type

[**TableConfDTO**](TableConfDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createFloorConfiguration**
> FloorDTO createFloorConfiguration(floorDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final floorDTO = FloorDTO(); // FloorDTO | 

try {
    final result = api_instance.createFloorConfiguration(floorDTO);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->createFloorConfiguration: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **floorDTO** | [**FloorDTO**](FloorDTO.md)|  | 

### Return type

[**FloorDTO**](FloorDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteFloorConfiguration**
> deleteFloorConfiguration(branchCode, floorCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 
final floorCode = floorCode_example; // String | 

try {
    api_instance.deleteFloorConfiguration(branchCode, floorCode);
} catch (e) {
    print('Exception when calling FloorControllerApi->deleteFloorConfiguration: $e\n');
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

# **deleteTable**
> deleteTable(floorCode, tableCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final floorCode = floorCode_example; // String | 
final tableCode = tableCode_example; // String | 

try {
    api_instance.deleteTable(floorCode, tableCode);
} catch (e) {
    print('Exception when calling FloorControllerApi->deleteTable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **floorCode** | **String**|  | 
 **tableCode** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFloorByBranchCode**
> List<FloorDTO> getFloorByBranchCode(branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.getFloorByBranchCode(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->getFloorByBranchCode: $e\n');
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

# **getFloorByBranchCodeAndDate**
> List<FloorDTO> getFloorByBranchCodeAndDate(branchCode, zonedDateTime)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final branchCode = branchCode_example; // String | 
final zonedDateTime = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final result = api_instance.getFloorByBranchCodeAndDate(branchCode, zonedDateTime);
    print(result);
} catch (e) {
    print('Exception when calling FloorControllerApi->getFloorByBranchCodeAndDate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **zonedDateTime** | **DateTime**|  | 

### Return type

[**List<FloorDTO>**](FloorDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeBookingCalendarFromTable**
> removeBookingCalendarFromTable(tableCode, bookingCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = FloorControllerApi();
final tableCode = tableCode_example; // String | 
final bookingCode = bookingCode_example; // String | 

try {
    api_instance.removeBookingCalendarFromTable(tableCode, bookingCode);
} catch (e) {
    print('Exception when calling FloorControllerApi->removeBookingCalendarFromTable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tableCode** | **String**|  | 
 **bookingCode** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

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

