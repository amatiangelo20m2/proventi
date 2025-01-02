import 'package:flutter/cupertino.dart';
import 'package:proventi/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:proventi/api/restaurant_client/lib/api.dart';

class CustomerStateManager extends ChangeNotifier {

  late ApiClient _restaurantClient;

  late CustomerControllerApi _customerControllerApi;

  List<CustomerHistoryDTO>? _historicalCustomerData = [];
  List<CustomerHistoryDTO>? get historicalCustomerData => _historicalCustomerData;

  late String branchCode = '';

  CustomerStateManager() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    print('Initialize client with $customBasePathRestaurant. Each call will be redirect to this url.');
    final prefs = await SharedPreferences.getInstance();
    branchCode = prefs.getString('branchCode')!;
    _restaurantClient = ApiClient(basePath: customBasePathRestaurant);
    _customerControllerApi = CustomerControllerApi(_restaurantClient);
    await retrieveCustomersListByBranchCode(branchCode, true);
  }

  retrieveCustomersListByBranchCode(String branchCode, bool refresh) async {
    _historicalCustomerData = await _customerControllerApi.retrieveHistoricalCustomersBasedOnReservationsByBranchCode(branchCode);
    notifyListeners();
  }


  Future<void> refreshHistory() async {
    final prefs = await SharedPreferences.getInstance();
    branchCode = prefs.getString('branchCode')!;
    //_currentCustomersList = await _customerControllerApi.retrieveCustomerHistoryByBranchCode(branchCode!);
    _historicalCustomerData = await _customerControllerApi.retrieveHistoricalCustomersBasedOnReservationsByBranchCode(branchCode!);
    notifyListeners();
  }





}