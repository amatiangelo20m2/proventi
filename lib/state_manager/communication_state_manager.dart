import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/communication_client/lib/api.dart';
import '../environment_config.dart';

class CommunicationStateManager extends ChangeNotifier {

  late ApiClient _communicationClient;

  late WhatsAppConfigurationControllerApi whatsAppConfigurationControllerApi;

  CommunicationStateManager(){
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    print('Initialize client with $customBasePathCommunication. Each call will be redirect to this url.');
    _communicationClient = ApiClient(basePath: customBasePathCommunication);
    whatsAppConfigurationControllerApi = WhatsAppConfigurationControllerApi(_communicationClient);
  }

  Future<WhatsAppConfigurationDTO?> retrieveWaApiConfStatus() async {


    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();

    return await whatsAppConfigurationControllerApi.retrieveWaApiConfStatus(branchCode);

  }
}