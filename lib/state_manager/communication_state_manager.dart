import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart' as RESTAURANT_CLIENT;
import 'package:shared_preferences/shared_preferences.dart';
import '../api/communication_client/lib/api.dart';
import '../environment_config.dart';

class CommunicationStateManager extends ChangeNotifier {

  late ApiClient _communicationClient;

  late WhatsAppConfigurationControllerApi whatsAppConfigurationControllerApi;

  CommunicationStateManager(){
    _initializeClient();
    _initializePrefs();
  }

  late final SharedPreferences prefs;

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _initializeClient() async {
    print('Initialize client with $customBasePathCommunication. Each call will be redirect to this url.');
    _communicationClient = ApiClient(basePath: customBasePathCommunication);
    whatsAppConfigurationControllerApi = WhatsAppConfigurationControllerApi(_communicationClient);

  }

  DateTime? _lastApiCallTime;
  static const int _apiCallIntervalSeconds = 20;
  WhatsAppConfigurationDTO? currentWhatsAppConfigurationDTO;

  Future<WhatsAppConfigurationDTO?> retrieveWaApiConfStatus() async {
    final currentTime = DateTime.now();

    // Check if 60 seconds have passed since the last API call
    if (_lastApiCallTime != null && currentTime.difference(_lastApiCallTime!).inSeconds < _apiCallIntervalSeconds) {
      print('Skipping API call, last call was less than ${_apiCallIntervalSeconds}seconds ago.');
      return currentWhatsAppConfigurationDTO;
    }

    // Update the last call time
    _lastApiCallTime = currentTime;

    //final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();
    // Make the API call
    currentWhatsAppConfigurationDTO = await whatsAppConfigurationControllerApi.retrieveWaApiConfStatus(branchCode);
    if(currentWhatsAppConfigurationDTO != null){

      //TODO: active the chat whatsapp retrieve when is ready
      retrieveChatData();
    }
    return currentWhatsAppConfigurationDTO;
  }

  List<AllChatListDataDTO>? chatList = [];


  Future<void> retrieveChatData() async {
    try {

      print('chat data set${chatList!.length.toString()}');
      //final prefs = await SharedPreferences.getInstance();
      print('chat data set${chatList!.length.toString()}');
      String branchCode = prefs.getString('branchCode').toString();
      print('chat data set${chatList!.length.toString()}');
      chatList = await whatsAppConfigurationControllerApi.fetchAllMessages(branchCode, 30);

      print('chat data set ${chatList!.length.toString()}');
      print('chat data set ${chatList!.toList().toString()}');

    }catch(e){
      print('chat data set${chatList!.length.toString()}');
      print('Error: ' + e.toString());
    }

    notifyListeners();
  }



  Future<void> sendWhatsAppMessage(String phone, ChatMessage chatMessage) async {
    //final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();
    await whatsAppConfigurationControllerApi.sendMessage(branchCode, chatMessage.text, phone);

    messages.insert(0, chatMessage);
    notifyListeners();

  }

  List<ChatMessage> messages = [];

  Future<ChatMessagesResponseDTO?> retrieveChatSpecificWithUserData(String customerNumber) async {

    //final prefs = await SharedPreferences.getInstance();
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

  checkIfChatsContainCurrentNumberWithUnreadChats(RESTAURANT_CLIENT.BookingDTO booking) {

      if(chatList!.where((element) => element.fromNumber
          == '${booking.customer!.prefix}${booking.customer!.phone}@c.us').isNotEmpty) {
        AllChatListDataDTO chatListDataDTO = chatList!.where((element) => element.fromNumber == '${booking.customer!.prefix}${booking.customer!.phone}@c.us').first;
        if(chatListDataDTO.unreadCount! > 0
            && !chatListDataDTO.fromMe!){
          return true;
        }
      }
      return false;
  }
}