# ventimetri_api_auth
No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)

This Dart package is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: v0
- Build package: org.openapitools.codegen.languages.DartClientCodegen

## Requirements

Dart 2.12 or later

## Installation & Usage

### Github
If this Dart package is published to Github, add the following dependency to your pubspec.yaml
```
dependencies:
  ventimetri_api_auth:
    git: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
```

### Local
To use the package in your local drive, add the following dependency to your pubspec.yaml
```
dependencies:
  ventimetri_api_auth:
    path: /path/to/ventimetri_api_auth
```

## Tests

TODO

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

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

## Documentation for API Endpoints

All URIs are relative to *http://192.168.1.9:64702/ventimetriauth*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*AuthControllerApi* | [**deleteUserByEmail**](doc//AuthControllerApi.md#deleteuserbyemail) | **DELETE** /api/auth/delete | 
*AuthControllerApi* | [**getFcmTokenByUserCode**](doc//AuthControllerApi.md#getfcmtokenbyusercode) | **GET** /api/auth/getfcmtoken | 
*AuthControllerApi* | [**resetPassword**](doc//AuthControllerApi.md#resetpassword) | **PUT** /api/auth/reset/password | 
*AuthControllerApi* | [**retrieveUserByEmail**](doc//AuthControllerApi.md#retrieveuserbyemail) | **GET** /api/auth/retrieve | 
*AuthControllerApi* | [**retrieveUserByUserCode**](doc//AuthControllerApi.md#retrieveuserbyusercode) | **GET** /api/auth/retrievebyusercode | 
*AuthControllerApi* | [**signIn**](doc//AuthControllerApi.md#signin) | **POST** /api/auth/sign-in | 
*AuthControllerApi* | [**signInWithGoogle**](doc//AuthControllerApi.md#signinwithgoogle) | **POST** /api/auth/google/sign-in | 
*AuthControllerApi* | [**signInWithToken**](doc//AuthControllerApi.md#signinwithtoken) | **POST** /api/auth/sign-in-with-token | 
*AuthControllerApi* | [**signInWithUserCode**](doc//AuthControllerApi.md#signinwithusercode) | **POST** /api/auth/sign-in-with-user-code | 
*AuthControllerApi* | [**signUp**](doc//AuthControllerApi.md#signup) | **POST** /api/auth/sign-up | 
*AuthControllerApi* | [**updateUser**](doc//AuthControllerApi.md#updateuser) | **PUT** /api/auth/update | 


## Documentation For Models

 - [AuthResponseEntity](doc//AuthResponseEntity.md)
 - [Credentials](doc//Credentials.md)
 - [JwtEntity](doc//JwtEntity.md)
 - [UpdateUserEntity](doc//UpdateUserEntity.md)
 - [UserCodeCredential](doc//UserCodeCredential.md)
 - [UserResponseEntity](doc//UserResponseEntity.md)


## Documentation For Authorization

Endpoints do not require authorization.


## Author


