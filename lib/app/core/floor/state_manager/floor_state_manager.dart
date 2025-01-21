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

  turnIsEdited(){
    isEdited = true;
    notifyListeners();
  }

  saveCurrentConfiguration() async {
    isEdited = false;
    currentFloor = await _floorControllerApi.updateFloorConfiguration(currentFloor.branchCode!, currentFloor).then((value) => value!);
    notifyListeners();
  }

  Future<void> loadData(String branchCode) async {
    try {
      floorList = await _floorControllerApi.getFloorByBranchCode(branchCode);
      setCurrentFloor(floorList!.first.floorCode!);
      notifyListeners();
    } catch (e) {
      print('Error loading data: $e');
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


}