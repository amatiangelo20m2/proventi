import 'package:flutter/cupertino.dart';
import 'package:proventi/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../api/restaurant_client/lib/api.dart';

class EmployeeStateManager with ChangeNotifier {

  late ApiClient _restaurantClient;
  late RestaurantControllerApi? _restaurantControllerApi;
  DateTime now = DateTime.now();

  RestaurantControllerApi? get restaurantControllerApi => _restaurantControllerApi;

  List<EmployeeDTO>? currentEmployeeList = [];

  EmployeeStateManager(){
    initializeClient();
  }

  Future<void> initializeClient() async {
    print('Initialize employee client inside employee state manager client with $customBasePathRestaurant. Each call will be redirect to this url.');
    _restaurantClient = ApiClient(basePath: customBasePathRestaurant);
    _restaurantControllerApi = RestaurantControllerApi(_restaurantClient);
    await retrieveCurrentEmployee();
  }

  retrieveCurrentEmployee() async {

    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();
    print('Current branch code (for employee report purpose): $branchCode');
    //print('User code (for notification purposes): ' + prefs.getString('user_code').toString());

    currentEmployeeList!.clear();
    RestaurantDTO? restaurantDTO = await _restaurantControllerApi!.retrieveConfiguration(branchCode,'XXX');

    print('Restaurant conf found: $restaurantDTO');

    currentEmployeeList = await _restaurantControllerApi!.getEmployeeListByBranchCode(branchCode);
    print('Employee list for branch with code Lenght ($branchCode) ->${currentEmployeeList!.length.toString()}');
    print('Employee list for branch with code ($branchCode) ->$currentEmployeeList');
    notifyListeners();
  }

  turnIsVisibleValueToEmployee(EmployeeDTO employeeDTO) async {

    try{
      await _restaurantControllerApi!.hideEmployee(employeeDTO.employeeId!);
      EmployeeDTO employee = currentEmployeeList!.where((element) => element.employeeId == employeeDTO.employeeId).first;
      employee.visible = !employee.visible!;
    }catch(e){
      print('Error: $e');
    }
    notifyListeners();
  }


  Future<List<EmployeePresenceReportDTO>?> getReportsByBranchCodeAndDate(DateTime selectedDate) async {

    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();

    print('Current branch code to get report employee: $branchCode');
    return await _restaurantControllerApi!.getReportsByBranchCodeAndDate(branchCode, selectedDate);
  }
}