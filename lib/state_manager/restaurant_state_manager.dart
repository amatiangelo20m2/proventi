import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/global/style.dart';

import '../environment_config.dart';

class RestaurantStateManager extends ChangeNotifier {

  DateFormat format_yyyy_MM_dd = DateFormat('yyyy-MM-dd');

  late ApiClient _restaurantClient;

  late RestaurantControllerApi _restaurantControllerApi;
  late BookingControllerApi _bookingControllerApi;
  late FormControllerApi _formControllerApi;

  RestaurantDTO? _restaurantConfiguration;

  EmployeeDTO? _currentEmployee;

  List<BookingDTO>? _currentBookings = [];
  List<BookingDTO>? _allBookings = [];

  List<FormDTO>? _currentBranchForms = [];

  // GETTER METHODS
  RestaurantDTO? get restaurantConfiguration => _restaurantConfiguration;
  BookingControllerApi get bookingControllerApi => _bookingControllerApi;
  List<BookingDTO>? get allBookings => _allBookings;
  ApiClient get restaurantClient => _restaurantClient;
  RestaurantControllerApi get restaurantControllerApi => _restaurantControllerApi;
  EmployeeDTO? get currentEmployee => _currentEmployee;
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
  }

  Future<void> setDataEmployeeAndRetrieveData(EmployeeDTO employee, DateTime dateTime) async {
    _currentEmployee = employee;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('branchCode', _currentEmployee!.branchCode!);

    _restaurantConfiguration = await _restaurantControllerApi.retrieveConfiguration(_currentEmployee!.branchCode!,'XXX');
    _currentBranchForms = await _formControllerApi.retrieveByBranchCode(_currentEmployee!.branchCode!);

    selectBookingForCurrentDay(dateTime);
    fetchAllBookings();
    notifyListeners();


  }

  List<BookingDTO>? get currentBookings {
    return _currentBookings;
  }

  updateBooking(BookingDTO bookingDTO) async {
    // Make the API call to update the booking

    BookingDTO? bookingDTOUpdated = await _bookingControllerApi.updateBooking(bookingDTO);
    setDataEmployeeAndRetrieveData(_currentEmployee!, DateTime.now());
  }


  Future<void> selectBookingForCurrentDay(DateTime dateTime) async {
    _currentBookings!.clear();
    _currentBookings = _allBookings!.where((element) => isSameDay(element.bookingDate!, dateTime)).toList();
    notifyListeners();
  }

  retrieveTotalGuestsNumberForDayAndActiveBookings(DateTime day) {
    return (_allBookings!.where((element) =>
    isSameDay(element.bookingDate!, day) && element.status == BookingDTOStatusEnum.CONFERMATO)
        .toList().fold(0, (total, booking) => total
        + (booking.numGuests ?? 0))).toString();
  }

  Future<void> fetchAllBookings() async {
    _allBookings = await _bookingControllerApi
        .retrieveBookingByStatusAndBranchCode(_currentEmployee!.branchCode!,
        format_yyyy_MM_dd.format(DateTime.now().subtract(Duration(days: 14))),
        format_yyyy_MM_dd.format(DateTime.now().add(const Duration(days: 360))));
    notifyListeners();
  }

  refresh(DateTime dateTime) {
    setDataEmployeeAndRetrieveData(_currentEmployee!, DateTime.now());
  }
}
