import 'package:flutter/cupertino.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../environment_config.dart';

class FloorStateManagerProvider extends ChangeNotifier {
  late ApiClient _restaurantClient;
  late FloorControllerApi _floorControllerApi;
  List<FloorDTO>? floorList = [];
  late FloorDTO currentFloor;

  bool isEdited = false;

  FloorControllerApi get floorControllerApi => _floorControllerApi;

  FloorStateManagerProvider() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    print('Initialize client with $customBasePathRestaurant. Each call will be redirected to this URL.');
    _restaurantClient = ApiClient(basePath: customBasePathRestaurant);
    _floorControllerApi = FloorControllerApi(_restaurantClient);
  }

  turnIsEdited(){
    isEdited = true;
    notifyListeners();
  }

  saveCurrentConfiguration() async {
    isEdited = false;
    currentFloor = await _floorControllerApi.updateFloorConfiguration(currentFloor.branchCode!, currentFloor).then((value) => value!);
    notifyListeners();
  }

  Future<void> loadData(String branchCode, DateTime date) async {
    try {
      floorList = [];
      floorList = await _floorControllerApi.getFloorByBranchCodeAndDate(branchCode, date);
      setCurrentFloor(floorList!.first.floorCode!);
      notifyListeners();
    } catch (e) {
      print('Error loading data: $e');
      floorList = [];
    }
  }

  Future<void> createFloor(FloorDTO floorDTO) async {
    _floorControllerApi.createFloorConfiguration(floorDTO).then((floorDTO){
      floorList!.add(floorDTO!);
      setCurrentFloor(floorDTO.floorCode!);
    });
    notifyListeners();
  }

  setCurrentFloor(String floorCode){
    currentFloor = floorList!.where((element) => element.floorCode == floorCode).first;
    notifyListeners();
  }

  addNewTable(TableConfDTO tableConf) async {
    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();

    print('Adding table to floor ${currentFloor.tables.toString()}');

    TableConfDTO? newTableConfDTO = await _floorControllerApi.addTableToFloor(
      branchCode,
      currentFloor.floorCode!,
      tableConf,
    );

    if (newTableConfDTO != null) {
      currentFloor.tables = List.from(currentFloor.tables)..add(newTableConfDTO);
    }
    notifyListeners();
  }

  Future<void> deleteTable(String tableCode) async {
    await _floorControllerApi.deleteTable(currentFloor.floorCode!, tableCode);
    currentFloor.tables = currentFloor.tables.where((element) => element.tableCode != tableCode).toList();
    notifyListeners();
  }


  void assignBookingToTable(String tableCode, String bookingCode, DateTime selectedDate, List<BookingDTO> allBookings) {
    isEdited = true;

    final table = currentFloor.tables.firstWhere((t) => t.tableCode == tableCode);
    table.tableBookingCalendarConf = List.from(table.tableBookingCalendarConf)
      ..add(TableBookingCalendar(bookingCode: bookingCode, date: selectedDate));

    // Sort the bookings by bookingHour and bookingMinutes
    table.tableBookingCalendarConf.sort((a, b) {
      final bookingA = allBookings.firstWhere((booking) => booking.bookingCode == a.bookingCode);
      final bookingB = allBookings.firstWhere((booking) => booking.bookingCode == b.bookingCode);

      final timeSlotA = bookingA.timeSlot!;
      final timeSlotB = bookingB.timeSlot!;

      final hourComparison = timeSlotA.bookingHour!.compareTo(timeSlotB.bookingHour!);
      if (hourComparison != 0) {
        return hourComparison;
      } else {
        return timeSlotA.bookingMinutes!.compareTo(timeSlotB.bookingMinutes!);
      }
    });

    // Notify listeners about the change
    notifyListeners();
  }

  List<BookingDTO> getFilteredBookings(List<BookingDTO> allBookings) {
    final assignedBookingCodes = currentFloor.tables
        .expand((table) => table.tableBookingCalendarConf)
        .map((conf) => conf.bookingCode)
        .toSet();

    return allBookings.where((booking) => !assignedBookingCodes.contains(booking.bookingCode)).toList();
  }

  void removeReservationFromTable(String tableCode, String bookingCode) {
    final table = currentFloor.tables.firstWhere((t) => t.tableCode == tableCode);
    table.tableBookingCalendarConf = List<TableBookingCalendar>.from(
        table.tableBookingCalendarConf.where((conf) => conf.bookingCode != bookingCode)
    );
    notifyListeners();
  }

}