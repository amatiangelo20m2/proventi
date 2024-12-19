import 'package:flutter/cupertino.dart';
import 'package:proventi/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../api/restaurant_client/lib/api.dart';

class EmployeeStateManager with ChangeNotifier {

  late ApiClient _restaurantClient;
  late RestaurantControllerApi? _restaurantControllerApi;
  late String userCode;
  late String branchCode;


  DateTime now = DateTime.now();

  RestaurantControllerApi? get restaurantControllerApi => _restaurantControllerApi;

  List<EmployeeDTO>? currentEmployeeList = [];

  EmployeeStateManager(){
    _initializeClient();
  }

  Future<void> _initializeClient() async {

    print('Initialize restaurant client inside employee state manager client with $customBasePathRestaurant. Each call will be redirect to this url.');

    final prefs = await SharedPreferences.getInstance();
    branchCode = prefs.getString('branch_code').toString();
    _restaurantClient = ApiClient(basePath: customBasePathRestaurant);
    _restaurantControllerApi = RestaurantControllerApi(_restaurantClient);
    await retrieveCurrentEmployee();
    // retrievePresenteEmployeeForCurrentBranchAndCurrentDate(branchCode, now);
  }

  retrieveCurrentEmployee() async {


    final prefs = await SharedPreferences.getInstance();

    print('Current branch code (for restaurant configuration purposes): $branchCode');
    //print('User code (for notification purposes): ' + prefs.getString('user_code').toString());

    branchCode = prefs.getString('branchCode').toString();

    RestaurantDTO? restaurantDTO = await _restaurantControllerApi!.retrieveConfiguration(branchCode,'XXX');

    print('Restaurant conf found: $restaurantDTO');
    currentEmployeeList = [];
    currentEmployeeList = await _restaurantControllerApi!.getEmployeeListByBranchCode(branchCode);
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
}