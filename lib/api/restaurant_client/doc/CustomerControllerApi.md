# ventimetri_api_restaurant.api.CustomerControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

All URIs are relative to *http://192.168.1.4:14918/restaurantservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**findcustomerByPhoneAndPrefix**](CustomerControllerApi.md#findcustomerbyphoneandprefix) | **GET** /api/customer/retrieve/{prefix}/{phoneNumber} | 
[**retrieveCustomerHistoryByBranchCode**](CustomerControllerApi.md#retrievecustomerhistorybybranchcode) | **GET** /api/customer/retrievecustomerhistory/{branchCode} | 
[**retrieveHistoricalCustomersBasedOnReservationsByBranchCode**](CustomerControllerApi.md#retrievehistoricalcustomersbasedonreservationsbybranchcode) | **GET** /api/customer/retrievehistoricalcustomers/{branchCode} | 
[**save**](CustomerControllerApi.md#save) | **POST** /api/customer/save | 
[**updateCustomer**](CustomerControllerApi.md#updatecustomer) | **PUT** /api/customer/updatecustomer | 


# **findcustomerByPhoneAndPrefix**
> CustomerDTO findcustomerByPhoneAndPrefix(prefix, phoneNumber)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CustomerControllerApi();
final prefix = prefix_example; // String | 
final phoneNumber = phoneNumber_example; // String | 

try {
    final result = api_instance.findcustomerByPhoneAndPrefix(prefix, phoneNumber);
    print(result);
} catch (e) {
    print('Exception when calling CustomerControllerApi->findcustomerByPhoneAndPrefix: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **prefix** | **String**|  | 
 **phoneNumber** | **String**|  | 

### Return type

[**CustomerDTO**](CustomerDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveCustomerHistoryByBranchCode**
> List<Object> retrieveCustomerHistoryByBranchCode(branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CustomerControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.retrieveCustomerHistoryByBranchCode(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling CustomerControllerApi->retrieveCustomerHistoryByBranchCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**List<Object>**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveHistoricalCustomersBasedOnReservationsByBranchCode**
> List<CustomerDTO> retrieveHistoricalCustomersBasedOnReservationsByBranchCode(branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CustomerControllerApi();
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.retrieveHistoricalCustomersBasedOnReservationsByBranchCode(branchCode);
    print(result);
} catch (e) {
    print('Exception when calling CustomerControllerApi->retrieveHistoricalCustomersBasedOnReservationsByBranchCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 

### Return type

[**List<CustomerDTO>**](CustomerDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **save**
> CustomerDTO save(customerDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CustomerControllerApi();
final customerDTO = CustomerDTO(); // CustomerDTO | 

try {
    final result = api_instance.save(customerDTO);
    print(result);
} catch (e) {
    print('Exception when calling CustomerControllerApi->save: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerDTO** | [**CustomerDTO**](CustomerDTO.md)|  | 

### Return type

[**CustomerDTO**](CustomerDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCustomer**
> CustomerDTO updateCustomer(customerDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CustomerControllerApi();
final customerDTO = CustomerDTO(); // CustomerDTO | 

try {
    final result = api_instance.updateCustomer(customerDTO);
    print(result);
} catch (e) {
    print('Exception when calling CustomerControllerApi->updateCustomer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerDTO** | [**CustomerDTO**](CustomerDTO.md)|  | 

### Return type

[**CustomerDTO**](CustomerDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

