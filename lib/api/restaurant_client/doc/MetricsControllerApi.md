# ventimetri_api_restaurant.api.MetricsControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

All URIs are relative to *http://192.168.1.9:12528/restaurantservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getBookingsMetricsLastTwoWeeks**](MetricsControllerApi.md#getbookingsmetricslasttwoweeks) | **GET** /api/metrics/bookings/last-two-weeks/{branchCode} | 
[**getCustomersMetricsByBranchCode**](MetricsControllerApi.md#getcustomersmetricsbybranchcode) | **GET** /api/metrics/customers/{branchCode} | 


# **getBookingsMetricsLastTwoWeeks**
> BookingsMetrics getBookingsMetricsLastTwoWeeks(branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = MetricsControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.getBookingsMetricsLastTwoWeeks(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling MetricsControllerApi->getBookingsMetricsLastTwoWeeks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**BookingsMetrics**](BookingsMetrics.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCustomersMetricsByBranchCode**
> CustomersMetrics getCustomersMetricsByBranchCode(branchCode, daysInThePast)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = MetricsControllerApi();
final branchCode = branchCode_example; // String | 
final daysInThePast = 56; // int | 

try {
    final result = api_instance.getCustomersMetricsByBranchCode(branchCode, daysInThePast);
    print(result);
} catch (e) {
    print('Exception when calling MetricsControllerApi->getCustomersMetricsByBranchCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **daysInThePast** | **int**|  | 

### Return type

[**CustomersMetrics**](CustomersMetrics.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

