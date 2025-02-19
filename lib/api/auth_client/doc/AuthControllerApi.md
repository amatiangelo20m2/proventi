# ventimetri_api_auth.api.AuthControllerApi

## Load the API package
```dart
import 'package:ventimetri_api_auth/api.dart';
```

All URIs are relative to *http://192.168.1.22:4657/ventimetriauth*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteUserByEmail**](AuthControllerApi.md#deleteuserbyemail) | **DELETE** /api/auth/delete | 
[**getAppVersion**](AuthControllerApi.md#getappversion) | **GET** /api/auth/proventi/version | 
[**getFcmTokenByUserCode**](AuthControllerApi.md#getfcmtokenbyusercode) | **GET** /api/auth/getfcmtoken | 
[**resetPassword**](AuthControllerApi.md#resetpassword) | **PUT** /api/auth/reset/password | 
[**retrieveUserByEmail**](AuthControllerApi.md#retrieveuserbyemail) | **GET** /api/auth/retrieve | 
[**retrieveUserByUserCode**](AuthControllerApi.md#retrieveuserbyusercode) | **GET** /api/auth/retrievebyusercode | 
[**signIn**](AuthControllerApi.md#signin) | **POST** /api/auth/sign-in | 
[**signInWithGoogle**](AuthControllerApi.md#signinwithgoogle) | **POST** /api/auth/google/sign-in | 
[**signInWithToken**](AuthControllerApi.md#signinwithtoken) | **POST** /api/auth/sign-in-with-token | 
[**signInWithUserCode**](AuthControllerApi.md#signinwithusercode) | **POST** /api/auth/sign-in-with-user-code | 
[**signUp**](AuthControllerApi.md#signup) | **POST** /api/auth/sign-up | 
[**updateUser**](AuthControllerApi.md#updateuser) | **PUT** /api/auth/update | 


# **deleteUserByEmail**
> deleteUserByEmail(email)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final email = email_example; // String | 

try {
    api_instance.deleteUserByEmail(email);
} catch (e) {
    print('Exception when calling AuthControllerApi->deleteUserByEmail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAppVersion**
> String getAppVersion()



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();

try {
    final result = api_instance.getAppVersion();
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->getAppVersion: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFcmTokenByUserCode**
> String getFcmTokenByUserCode(userCode)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final userCode = userCode_example; // String | 

try {
    final result = api_instance.getFcmTokenByUserCode(userCode);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->getFcmTokenByUserCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCode** | **String**|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> resetPassword(userCode, password)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final userCode = userCode_example; // String | 
final password = password_example; // String | 

try {
    api_instance.resetPassword(userCode, password);
} catch (e) {
    print('Exception when calling AuthControllerApi->resetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCode** | **String**|  | 
 **password** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveUserByEmail**
> UserResponseEntity retrieveUserByEmail(email)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final email = email_example; // String | 

try {
    final result = api_instance.retrieveUserByEmail(email);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->retrieveUserByEmail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 

### Return type

[**UserResponseEntity**](UserResponseEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveUserByUserCode**
> UserResponseEntity retrieveUserByUserCode(userCode)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final userCode = userCode_example; // String | 

try {
    final result = api_instance.retrieveUserByUserCode(userCode);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->retrieveUserByUserCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCode** | **String**|  | 

### Return type

[**UserResponseEntity**](UserResponseEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signIn**
> AuthResponseEntity signIn(credentials)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final credentials = Credentials(); // Credentials | 

try {
    final result = api_instance.signIn(credentials);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->signIn: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **credentials** | [**Credentials**](Credentials.md)|  | 

### Return type

[**AuthResponseEntity**](AuthResponseEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signInWithGoogle**
> AuthResponseEntity signInWithGoogle(credentials)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final credentials = Credentials(); // Credentials | 

try {
    final result = api_instance.signInWithGoogle(credentials);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->signInWithGoogle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **credentials** | [**Credentials**](Credentials.md)|  | 

### Return type

[**AuthResponseEntity**](AuthResponseEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signInWithToken**
> AuthResponseEntity signInWithToken(jwtEntity)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final jwtEntity = JwtEntity(); // JwtEntity | 

try {
    final result = api_instance.signInWithToken(jwtEntity);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->signInWithToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jwtEntity** | [**JwtEntity**](JwtEntity.md)|  | 

### Return type

[**AuthResponseEntity**](AuthResponseEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signInWithUserCode**
> AuthResponseEntity signInWithUserCode(userCodeCredential)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final userCodeCredential = UserCodeCredential(); // UserCodeCredential | 

try {
    final result = api_instance.signInWithUserCode(userCodeCredential);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->signInWithUserCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCodeCredential** | [**UserCodeCredential**](UserCodeCredential.md)|  | 

### Return type

[**AuthResponseEntity**](AuthResponseEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signUp**
> AuthResponseEntity signUp(credentials)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final credentials = Credentials(); // Credentials | 

try {
    final result = api_instance.signUp(credentials);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->signUp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **credentials** | [**Credentials**](Credentials.md)|  | 

### Return type

[**AuthResponseEntity**](AuthResponseEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> updateUser(updateUserEntity)



### Example
```dart
import 'package:ventimetri_api_auth/api.dart';

final api_instance = AuthControllerApi();
final updateUserEntity = UpdateUserEntity(); // UpdateUserEntity | 

try {
    api_instance.updateUser(updateUserEntity);
} catch (e) {
    print('Exception when calling AuthControllerApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserEntity** | [**UpdateUserEntity**](UpdateUserEntity.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

