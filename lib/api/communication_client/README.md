# ventimetri_api_communication
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
  ventimetri_api_communication:
    git: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
```

### Local
To use the package in your local drive, add the following dependency to your pubspec.yaml
```
dependencies:
  ventimetri_api_communication:
    path: /path/to/ventimetri_api_communication
```

## Tests

TODO

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

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

## Documentation for API Endpoints

All URIs are relative to *http://192.168.1.226:6003/communicationservice*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*CentralinoApiControllerApi* | [**manageCentralinoCall**](doc//CentralinoApiControllerApi.md#managecentralinocall) | **GET** /api/pro20 | 
*PushNotificationControllerApi* | [**sendMessage1**](doc//PushNotificationControllerApi.md#sendmessage1) | **POST** /api/pushnotification/sendmessage | 
*WhatsAppConfigurationControllerApi* | [**checkWaApiStatusAndNotifyUsers**](doc//WhatsAppConfigurationControllerApi.md#checkwaapistatusandnotifyusers) | **POST** /api/wsapicontroller/checkwaapistatusandnotifyusers/{branchCode}/{branchName} | 
*WhatsAppConfigurationControllerApi* | [**createConfWaApi**](doc//WhatsAppConfigurationControllerApi.md#createconfwaapi) | **GET** /api/wsapicontroller/createconf/{branchCode} | 
*WhatsAppConfigurationControllerApi* | [**deleteConfWaApi**](doc//WhatsAppConfigurationControllerApi.md#deleteconfwaapi) | **DELETE** /api/wsapicontroller/deleteConf/{branchCode} | 
*WhatsAppConfigurationControllerApi* | [**fetchAllMessages**](doc//WhatsAppConfigurationControllerApi.md#fetchallmessages) | **GET** /api/wsapicontroller/fetchallmessages/{branchCode}/{chatNum} | 
*WhatsAppConfigurationControllerApi* | [**fetchMessages**](doc//WhatsAppConfigurationControllerApi.md#fetchmessages) | **GET** /api/wsapicontroller/fetchmessages/{branchCode}/{userPhone}/{messageNum}/{fetchMedia} | 
*WhatsAppConfigurationControllerApi* | [**retrievePairingCodeWaApi**](doc//WhatsAppConfigurationControllerApi.md#retrievepairingcodewaapi) | **GET** /api/wsapicontroller/requestpairingcode/{branchCode}/{prefix}/{number} | 
*WhatsAppConfigurationControllerApi* | [**retrieveQr**](doc//WhatsAppConfigurationControllerApi.md#retrieveqr) | **GET** /api/wsapicontroller/retrieveqr/{branchCode} | 
*WhatsAppConfigurationControllerApi* | [**retrieveUserPhoto**](doc//WhatsAppConfigurationControllerApi.md#retrieveuserphoto) | **GET** /api/wsapicontroller/retrieveuserphoto/{branchCode}/{userPhone} | 
*WhatsAppConfigurationControllerApi* | [**retrieveWaApiConfStatus**](doc//WhatsAppConfigurationControllerApi.md#retrievewaapiconfstatus) | **GET** /api/wsapicontroller/retrieve/waconfstatus/{branchCode} | 
*WhatsAppConfigurationControllerApi* | [**sendMessage**](doc//WhatsAppConfigurationControllerApi.md#sendmessage) | **POST** /api/wsapicontroller/sendmessage/{branchCode} | 


## Documentation For Models

 - [AllChatListDataDTO](doc//AllChatListDataDTO.md)
 - [ChatMessagesResponseDTO](doc//ChatMessagesResponseDTO.md)
 - [MessageDataDTO](doc//MessageDataDTO.md)
 - [WhatsAppConfigurationDTO](doc//WhatsAppConfigurationDTO.md)


## Documentation For Authorization

Endpoints do not require authorization.


## Author



