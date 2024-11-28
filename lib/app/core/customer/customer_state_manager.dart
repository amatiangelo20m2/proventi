import 'package:flutter/cupertino.dart';
import 'package:proventi/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:proventi/api/restaurant_client/lib/api.dart';

class CustomerStateManager extends ChangeNotifier {

  late ApiClient _restaurantClient;

  late CustomerControllerApi _customerControllerApi;

  List<CustomerHistory>? _currentCustomersList = [];
  List<CustomerHistory>? get currentCustomersList => _currentCustomersList;

  List<CustomerDTO>? _currentCutomerDTOList = [];
  List<CustomerDTO>? get currentCustomerDTOList => _currentCutomerDTOList;

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

    if(refresh){
      _currentCustomersList = await _customerControllerApi.retrieveCustomerHistoryByBranchCode(branchCode);
    }
    _currentCutomerDTOList = await _customerControllerApi
        .retrieveHistoricalCustomersBasedOnReservationsByBranchCode(branchCode);
    notifyListeners();
  }

  Future<void> refreshHistory() async {
    final prefs = await SharedPreferences.getInstance();
    branchCode = prefs.getString('branchCode')!;
    _currentCustomersList = await _customerControllerApi.retrieveCustomerHistoryByBranchCode(branchCode!);
    _currentCutomerDTOList = await _customerControllerApi.retrieveHistoricalCustomersBasedOnReservationsByBranchCode(branchCode!);
    notifyListeners();
  }





}