import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/global/style.dart';
import '../environment_config.dart';
import '../global/date_methods_utility.dart';

class RestaurantStateManager extends ChangeNotifier {

  DateFormat format_yyyy_MM_dd = DateFormat('yyyy-MM-dd');

  late ApiClient _restaurantClient;

  late RestaurantControllerApi _restaurantControllerApi;
  late BookingControllerApi _bookingControllerApi;
  late FormControllerApi _formControllerApi;
  late CustomerControllerApi _customerControllerApi;


  List<RestaurantDTO>? _restaurantConfigurations = [];
  RestaurantDTO? _choosedRestaurantConfiguration = RestaurantDTO(restaurantName: 'Loading..', branchCode: 'Loading..');
  List<BookingDTO>? _allBookings = [];
  List<FormDTO>? _currentBranchForms = [];

  // GETTER METHODS
  RestaurantDTO? get restaurantConfiguration => _choosedRestaurantConfiguration;
  BookingControllerApi get bookingControllerApi => _bookingControllerApi;
  List<BookingDTO>? get allBookings => _allBookings;
  List<RestaurantDTO>? get restaurantConfigurations => _restaurantConfigurations;
  ApiClient get restaurantClient => _restaurantClient;
  RestaurantControllerApi get restaurantControllerApi => _restaurantControllerApi;
  CustomerControllerApi get customerControllerApi => _customerControllerApi;

  //EmployeeDTO? get currentEmployee => _currentEmployee;
  List<FormDTO>? get currentBranchForms => _currentBranchForms;

  RestaurantStateManager() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    print('Initialize client with $customBasePathRestaurant. Each call will be redirect to this url.');

    _restaurantClient = ApiClient(basePath: customBasePathRestaurant);
    _restaurantControllerApi = RestaurantControllerApi(_restaurantClient);
    _bookingControllerApi = BookingControllerApi(_restaurantClient);

    _formControllerApi = FormControllerApi(_restaurantClient);
    _customerControllerApi = CustomerControllerApi(_restaurantClient);
  }

  refreshDate(){
    retrieveBranchConfiguration(_choosedRestaurantConfiguration!.branchCode!, DateTime.now());
    notifyListeners();
  }

  setBranchList(List<RestaurantDTO> restaurantDTOList) {
    if(restaurantDTOList!.isNotEmpty) {
      _restaurantConfigurations = restaurantDTOList;
      retrieveBranchConfiguration(_restaurantConfigurations!.first.branchCode!, DateTime.now());
    }
    notifyListeners();
  }


  Future<void> retrieveBranchConfiguration(String branchCode, DateTime dateTime) async {
    print('Branch code to retrieve: $branchCode');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('branchCode', branchCode);

    _choosedRestaurantConfiguration = await _restaurantControllerApi.retrieveConfiguration(branchCode, 'XXX');
    _currentBranchForms = await _formControllerApi.retrieveByBranchCode(branchCode);
    fetchAllBookings();
    notifyListeners();
  }

  updateBooking(BookingDTO bookingDTO, bool sendMessage) async {
    print('uipdatetgedgfvdfv');
      await _bookingControllerApi.updateBooking(sendMessage, bookingDTO);
      retrieveBranchConfiguration(_choosedRestaurantConfiguration!.branchCode!, DateTime.now());
  }

  retrieveTotalGuestsNumberForDayAndActiveBookings(DateTime day) {
    return (_allBookings!.where((element) =>
    isSameDay(element.bookingDate!, day) && element.status == BookingDTOStatusEnum.CONFERMATO)
        .toList().fold(0, (total, booking) => total
        + (booking.numGuests ?? 0)));
  }

  retrieveTotalTableNumberForDayAndActiveBookings(DateTime day) {
    return (_allBookings!.where((element) =>
    isSameDay(element.bookingDate!, day) && element.status == BookingDTOStatusEnum.CONFERMATO)
        .toList().length);
  }

  retrieveTotalGuestsNumberForDayAndActiveBookingsLunchTime(DateTime day, RestaurantDTO restaurantDTO) {
    return (_allBookings!.where((element) =>
    isSameDay(element.bookingDate!, day) && element.status == BookingDTOStatusEnum.CONFERMATO && isLunchTime(element, restaurantDTO))
        .toList().fold(0, (total, booking) => total
        + (booking.numGuests ?? 0)));
  }

  retrieveTotalTablesNumberForDayAndActiveBookingsLunchTime(DateTime day, RestaurantDTO restaurantDTO) {
    return (_allBookings!.where((element) => isSameDay(element.bookingDate!, day) && element.status
        == BookingDTOStatusEnum.CONFERMATO && isLunchTime(element, restaurantDTO)).toList().length);
  }


  retrieveTotalGuestsNumberForDayAndActiveBookingsDinnerTime(DateTime day, RestaurantDTO restaurantDTO) {
    return (_allBookings!.where((element) =>
    isSameDay(element.bookingDate!, day) && element.status == BookingDTOStatusEnum.CONFERMATO && !isLunchTime(element, restaurantDTO))
        .toList().fold(0, (total, booking) => total
        + (booking.numGuests ?? 0)));
  }

  retrieveTotalTablesNumberForDayAndActiveBookingsDinnerTime(DateTime day, RestaurantDTO restaurantDTO) {
    return (_allBookings!.where((element) => isSameDay(element.bookingDate!, day) && element.status
        == BookingDTOStatusEnum.CONFERMATO && !isLunchTime(element, restaurantDTO)).toList().length);
  }


  Future<void> fetchAllBookings() async {
    _allBookings = await _bookingControllerApi
        .retrieveBookingByStatusAndBranchCode(_choosedRestaurantConfiguration!.branchCode!,
        format_yyyy_MM_dd.format(DateTime.now().subtract(const Duration(days: 14))),
        format_yyyy_MM_dd.format(DateTime.now().add(const Duration(days: 360))));
    notifyListeners();
  }

  refresh(DateTime dateTime) {
    print('refresh with code '+ _choosedRestaurantConfiguration!.branchCode!);
    retrieveBranchConfiguration(_choosedRestaurantConfiguration!.branchCode!, dateTime);
  }

  List<BookingDTO> bookingFilteredByCurrentDate(DateTime date){
    return _allBookings!.where((element) => isSameDay(element.bookingDate!, date)).toList();
  }

  void setNewRestaurantConfiguration(RestaurantDTO restaurantDTO) {
    _choosedRestaurantConfiguration = restaurantDTO;
    notifyListeners();
  }

  updateAutomaticBookingManageConfiguration(DateTime currentDate,
      {required bool acceptLunch, required bool refuseLunch, required bool acceptDinner, required bool refuseDinner}) async {
    RestaurantDTO? restaurantDTO = await restaurantControllerApi.updateApproveRefuseBookConf(
      restaurantConfiguration!.branchCode!,
      AutomaticApproveRefusedBookConf(
        date: currentDate,
        doAcceptBookingLunch: acceptLunch,
        doRefuseBookingLunch: refuseLunch,
        doAcceptBookingDinner: acceptDinner,
        doRefuseBookingDinner: refuseDinner,
      ),
    );
    setNewRestaurantConfiguration(restaurantDTO!);
  }
}
