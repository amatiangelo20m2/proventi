# ventimetri_api_restaurant.model.RestaurantDTO

## Load the model package
```dart
import 'package:ventimetri_api_restaurant/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchCode** | **String** |  | [optional] 
**creationDate** | [**DateTime**](DateTime.md) |  | [optional] 
**daylyTimeWorkingRange** | [**TimeRange**](TimeRange.md) |  | [optional] 
**nightTimeWorkingRange** | [**TimeRange**](TimeRange.md) |  | [optional] 
**capacity** | **int** |  | [optional] 
**standardMessages** | [**List<StandardMessage>**](StandardMessage.md) |  | [optional] [default to const []]
**afterBookingSchedulerMessages** | [**List<AfterBookingSchedulerMessage>**](AfterBookingSchedulerMessage.md) |  | [optional] [default to const []]
**beforeBookingScheduledMessages** | [**List<BeforeBookingScheduledMessage>**](BeforeBookingScheduledMessage.md) |  | [optional] [default to const []]
**centralinoMessages** | [**List<CentralinoMessage>**](CentralinoMessage.md) |  | [optional] [default to const []]
**automaticApproveRefuseBookConf** | [**List<AutomaticApproveRefusedBookConf>**](AutomaticApproveRefusedBookConf.md) |  | [optional] [default to const []]
**restaurantName** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


