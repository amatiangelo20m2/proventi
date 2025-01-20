import 'package:flutter/cupertino.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../environment_config.dart';

class FloorStateManagerProvider extends ChangeNotifier {
  late ApiClient _restaurantClient;
  late FloorControllerApi _floorControllerApi;
  List<FloorDTO>? floorList = [];
  late FloorDTO currentFloor;

  List<TableConf> tables = [];
  List<FloorCalendar> floorCalendars = [];
  List<BookingDTO> bookings = [];

  FloorControllerApi get floorControllerApi => _floorControllerApi;

  FloorStateManagerProvider() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    print('Initialize client with $customBasePathRestaurant. Each call will be redirected to this URL.');
    _restaurantClient = ApiClient(basePath: customBasePathRestaurant);
    _floorControllerApi = FloorControllerApi(_restaurantClient);
  }

  setBookingList(List<BookingDTO> bookingList) {
    bookings = bookingList;
    notifyListeners();
  }

  Future<void> loadData(String branchCode) async {
    try {
      floorList = await _floorControllerApi.getFloorByBranchCodeAndDate(branchCode);
      setCurrentFloor(floorList!.first!.floorCode!);
      notifyListeners();
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> createFloor(FloorDTO floorDTO) async {
    _floorControllerApi.createFloorConfiguration(floorDTO.branchCode!,
        floorDTO).then((floorDTO){
      floorList!.add(floorDTO!);
      setCurrentFloor(floorDTO.floorCode!);
    });
    notifyListeners();
  }

  setCurrentFloor(String floorCode){
    currentFloor = floorList!.where((element) => element.floorCode == floorCode).first;
    notifyListeners();
  }

  void setFloorList(List<FloorDTO> floorList) {
    this.floorList = floorList;
    setCurrentFloor(floorList!.first.floorCode!);
    tables = List.from(currentFloor.tables); // Create a new list from currentFloor.tables
    notifyListeners();
  }

  void addNewTable(TableConf tableConf) {
    print('Create table:' + tableConf.toString());
    try {
      tables.add(tableConf);
    } catch (e) {
      print('Error adding table: $e');
    }

    notifyListeners();
  }

  void updateCoordinatesOfTable(String tableCode, double newX, double newY) {

    var table = tables.firstWhere((element) => element.code == tableCode);
    table.offsetX = newX;
    table.offsetY = newY;
    notifyListeners();
    }
}