# ventimetri_api_restaurant.api.BookingControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

All URIs are relative to *http://192.168.1.9:23012/restaurantservice*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create**](BookingControllerApi.md#create) | **POST** /api/booking/create | 
[**deleteBooking**](BookingControllerApi.md#deletebooking) | **DELETE** /api/booking/delete/{bookingCode} | 
[**findBookingByCustomerEmail**](BookingControllerApi.md#findbookingbycustomeremail) | **GET** /api/booking/retrievebycustomeremail/{email} | 
[**findBookingByCustomerPrefixAndPhone**](BookingControllerApi.md#findbookingbycustomerprefixandphone) | **GET** /api/booking/retrievebyphone/{prefix}/{phone}/{branchCode} | 
[**findBookingByFormCode**](BookingControllerApi.md#findbookingbyformcode) | **GET** /api/booking/retrievebyformcode/{formCode} | 
[**retrieveBookingByBranchCodeAndDate**](BookingControllerApi.md#retrievebookingbybranchcodeanddate) | **GET** /api/booking/retrievebynranchcode/{branchCode}/{date} | 
[**retrieveBookingByCode**](BookingControllerApi.md#retrievebookingbycode) | **GET** /api/booking/retrievebooking/{bookingCode} | 
[**retrieveBookingByStatusAndBranchCode**](BookingControllerApi.md#retrievebookingbystatusandbranchcode) | **GET** /api/booking/retrievebynranchcode/{branchCode}/{fromDate}/{toDate} | 
[**updateBooking**](BookingControllerApi.md#updatebooking) | **PUT** /api/booking/updatebooking | 


# **create**
> BookingDTO create(bookingDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final bookingDTO = BookingDTO(); // BookingDTO | 

try {
    final result = api_instance.create(bookingDTO);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingDTO** | [**BookingDTO**](BookingDTO.md)|  | 

### Return type

[**BookingDTO**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBooking**
> deleteBooking(bookingCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final bookingCode = bookingCode_example; // String | 

try {
    api_instance.deleteBooking(bookingCode);
} catch (e) {
    print('Exception when calling BookingControllerApi->deleteBooking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingCode** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **findBookingByCustomerEmail**
> List<BookingDTO> findBookingByCustomerEmail(email)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final email = email_example; // String | 

try {
    final result = api_instance.findBookingByCustomerEmail(email);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->findBookingByCustomerEmail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 

### Return type

[**List<BookingDTO>**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **findBookingByCustomerPrefixAndPhone**
> List<BookingDTO> findBookingByCustomerPrefixAndPhone(prefix, phone, branchCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final prefix = prefix_example; // String | 
final phone = phone_example; // String | 
final branchCode = branchCode_example; // String | 

try {
    final result = api_instance.findBookingByCustomerPrefixAndPhone(prefix, phone, branchCode);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->findBookingByCustomerPrefixAndPhone: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **prefix** | **String**|  | 
 **phone** | **String**|  | 
 **branchCode** | **String**|  | 

### Return type

[**List<BookingDTO>**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **findBookingByFormCode**
> List<BookingDTO> findBookingByFormCode(formCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final formCode = formCode_example; // String | 

try {
    final result = api_instance.findBookingByFormCode(formCode);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->findBookingByFormCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **formCode** | **String**|  | 

### Return type

[**List<BookingDTO>**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveBookingByBranchCodeAndDate**
> List<BookingDTO> retrieveBookingByBranchCodeAndDate(branchCode, date)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final branchCode = branchCode_example; // String | 
final date = date_example; // String | 

try {
    final result = api_instance.retrieveBookingByBranchCodeAndDate(branchCode, date);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->retrieveBookingByBranchCodeAndDate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **date** | **String**|  | 

### Return type

[**List<BookingDTO>**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveBookingByCode**
> BookingDTO retrieveBookingByCode(bookingCode)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final bookingCode = bookingCode_example; // String | 

try {
    final result = api_instance.retrieveBookingByCode(bookingCode);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->retrieveBookingByCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingCode** | **String**|  | 

### Return type

[**BookingDTO**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveBookingByStatusAndBranchCode**
> List<BookingDTO> retrieveBookingByStatusAndBranchCode(branchCode, fromDate, toDate)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final branchCode = branchCode_example; // String | 
final fromDate = fromDate_example; // String | 
final toDate = toDate_example; // String | 

try {
    final result = api_instance.retrieveBookingByStatusAndBranchCode(branchCode, fromDate, toDate);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->retrieveBookingByStatusAndBranchCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **branchCode** | **String**|  | 
 **fromDate** | **String**|  | 
 **toDate** | **String**|  | 

### Return type

[**List<BookingDTO>**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBooking**
> BookingDTO updateBooking(sendMessage, bookingDTO)



### Example
```dart
import 'package:ventimetri_api_restaurant/api.dart';

final api_instance = BookingControllerApi();
final sendMessage = true; // bool | 
final bookingDTO = BookingDTO(); // BookingDTO | 

try {
    final result = api_instance.updateBooking(sendMessage, bookingDTO);
    print(result);
} catch (e) {
    print('Exception when calling BookingControllerApi->updateBooking: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendMessage** | **bool**|  | 
 **bookingDTO** | [**BookingDTO**](BookingDTO.md)|  | 

### Return type

[**BookingDTO**](BookingDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

