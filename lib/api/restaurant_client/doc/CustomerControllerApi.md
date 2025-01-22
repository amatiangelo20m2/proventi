# ventimetri_api_restaurant.api.CustomerControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

All URIs are relative to *http://192.168.1.9:31083/restaurantservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**findCustomerByPhoneAndPrefixAndBranchCode**](CustomerControllerApi.md#findcustomerbyphoneandprefixandbranchcode) | **GET** /api/customer/retrieve/{prefix}/{phoneNumber}/{branchCode} | 
[**retrieveCustomerByQuery**](CustomerControllerApi.md#retrievecustomerbyquery) | **GET** /api/customer/retrievecustomer/queryfiltered/{branchCode} | 
[**retrieveHistoricalCustomersBasedOnReservationsByBranchCode**](CustomerControllerApi.md#retrievehistoricalcustomersbasedonreservationsbybranchcode) | **GET** /api/customer/retrievehistoricalcustomers/{branchCode} | 
[**save**](CustomerControllerApi.md#save) | **POST** /api/customer/save | 
[**updateCustomer**](CustomerControllerApi.md#updatecustomer) | **PUT** /api/customer/updatecustomer | 


# **findCustomerByPhoneAndPrefixAndBranchCode**
> CustomerDTO findCustomerByPhoneAndPrefixAndBranchCode(prefix, phoneNumber, branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CustomerControllerApi();
final prefix = prefix_example; // String | 
final phoneNumber = phoneNumber_example; // String | 
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.findCustomerByPhoneAndPrefixAndBranchCode(prefix, phoneNumber, branchCode);
    print(result);
} catch (e) {
    print('Exception when calling CustomerControllerApi->findCustomerByPhoneAndPrefixAndBranchCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **prefix** | **String**|  | 
 **phoneNumber** | **String**|  | 
 **branchCode** | **String**|  | 

### Return type

[**CustomerDTO**](CustomerDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveCustomerByQuery**
> List<CustomerHistoryDTO> retrieveCustomerByQuery(branchCode, includeTags, excludeTags, minAge, maxAge, names)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = CustomerControllerApi();
final branchCode = branchCode_example; // String | 
final includeTags = includeTags_example; // String | 
final excludeTags = excludeTags_example; // String | 
final minAge = minAge_example; // String | 
final maxAge = maxAge_example; // String | 
final names = names_example; // String | 

try {
    final result = api_instance.retrieveCustomerByQuery(branchCode, includeTags, excludeTags, minAge, maxAge, names);
    print(result);
} catch (e) {
    print('Exception when calling CustomerControllerApi->retrieveCustomerByQuery: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **includeTags** | **String**|  | [optional] 
 **excludeTags** | **String**|  | [optional] 
 **minAge** | **String**|  | [optional] 
 **maxAge** | **String**|  | [optional] 
 **names** | **String**|  | [optional] 

### Return type

[**List<CustomerHistoryDTO>**](CustomerHistoryDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveHistoricalCustomersBasedOnReservationsByBranchCode**
> List<CustomerHistoryDTO> retrieveHistoricalCustomersBasedOnReservationsByBranchCode(branchCode)



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

[**List<CustomerHistoryDTO>**](CustomerHistoryDTO.md)

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

