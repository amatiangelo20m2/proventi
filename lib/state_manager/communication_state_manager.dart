import 'dart:collection';

import 'package:dash_chat_2/dash_chat_2.dart';
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

  DateTime? _lastApiCallTime;
  static const int _apiCallIntervalSeconds = 10;
  WhatsAppConfigurationDTO? currentWhatsAppConfigurationDTO;

  Future<WhatsAppConfigurationDTO?> retrieveWaApiConfStatus() async {
    final currentTime = DateTime.now();

    // Check if 60 seconds have passed since the last API call
    if (_lastApiCallTime != null && currentTime.difference(_lastApiCallTime!).inSeconds < _apiCallIntervalSeconds) {
      print('Skipping API call; last call was less than ${_apiCallIntervalSeconds}seconds ago.');
      return currentWhatsAppConfigurationDTO;
    }

    // Update the last call time
    _lastApiCallTime = currentTime;

    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();
    // Make the API call
    currentWhatsAppConfigurationDTO = await whatsAppConfigurationControllerApi.retrieveWaApiConfStatus(branchCode);
    if(currentWhatsAppConfigurationDTO != null){

      //TODO: active the chat whatsapp retrieve when is ready
      //retrieveChatData();
    }
    return currentWhatsAppConfigurationDTO;
  }

  Set<AllChatListDataDTO>? chatDataSet = HashSet();

  Future<void> retrieveChatData() async {
    try{
      print('chat data set${chatDataSet!.length.toString()}');
      final prefs = await SharedPreferences.getInstance();
      print('chat data set${chatDataSet!.length.toString()}');
      String branchCode = prefs.getString('branchCode').toString();
      print('chat data set${chatDataSet!.length.toString()}');
      chatDataSet = await whatsAppConfigurationControllerApi.fetchAllMessages(branchCode, 10);
      print('chat data set${chatDataSet!.length.toString()}');

    }catch(e){
      print('chat data set${chatDataSet!.length.toString()}');
      print('Error: ' + e.toString());
    }

    notifyListeners();
  }



  Future<void> sendWhatsAppMessage(String phone, ChatMessage chatMessage) async {
    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();
    await whatsAppConfigurationControllerApi.sendMessage(branchCode, chatMessage.text, phone);

    messages.insert(0, chatMessage);
    notifyListeners();

  }

  List<ChatMessage> messages = [];

  Future<ChatMessagesResponseDTO?> retrieveChatSpecificWithUserData(String customerNumber) async {

    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();

    ChatMessagesResponseDTO? chatMessageResponseDTO = await whatsAppConfigurationControllerApi.fetchMessages(branchCode,customerNumber, '20', false);


    return chatMessageResponseDTO;
  }

  void setCurrentMessages(List<ChatMessage> mapMessages) {
    messages = mapMessages;
    notifyListeners();

  }


  Map<String, String> urlsPhotos = Map();


  retrievePhotoUrlByPhone(String branchCode, String phoneNumber) async {

    if(urlsPhotos.containsKey(phoneNumber)){
      return urlsPhotos[phoneNumber];
    }else{
      String? photoUrl = await whatsAppConfigurationControllerApi.retrieveUserPhoto(branchCode, phoneNumber);
      urlsPhotos.putIfAbsent(phoneNumber, () => photoUrl!);
      return photoUrl;
    }
  }

}