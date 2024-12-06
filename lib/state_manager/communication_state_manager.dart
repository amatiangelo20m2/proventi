import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart' as RESTAURANT_CLIENT;
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:provider/provider.dart';
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
    retrieveWaApiConfStatus();
  }

  DateTime? _lastApiCallTime;
  static const int _apiCallIntervalSeconds = 75;
  WhatsAppConfigurationDTO? currentWhatsAppConfigurationDTO;

  Future<WhatsAppConfigurationDTO?> retrieveWaApiConfStatus() async {
    print('Refresh conf and in case retrieve chat daat');
    final currentTime = DateTime.now();
    // Check if 60 seconds have passed since the last API call
    if (_lastApiCallTime != null && currentTime.difference(_lastApiCallTime!).inSeconds
        < _apiCallIntervalSeconds) {
      print('Skipping API call, last call was less than ${_apiCallIntervalSeconds} seconds ago.');
      return currentWhatsAppConfigurationDTO;
    }

    // Update the last call time
    _lastApiCallTime = currentTime;

    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();
    // Make the API call
    currentWhatsAppConfigurationDTO = await whatsAppConfigurationControllerApi.retrieveWaApiConfStatus(branchCode);
    if(currentWhatsAppConfigurationDTO != null){
      retrieveChatData();
    }
    return currentWhatsAppConfigurationDTO;
  }

  List<AllChatListDataDTO>? chatList = [];

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<void> retrieveChatData() async {
    try {
      BuildContext context = navigatorKey.currentContext!;
      RestaurantStateManager restaurantStateManager =
      Provider.of<RestaurantStateManager>(context, listen: false);
      if(restaurantStateManager.allBookings!.isNotEmpty && restaurantStateManager.allBookings!.where((element) => element.status == RESTAURANT_CLIENT.BookingDTOStatusEnum.CONFERMATO).isNotEmpty){
        String branchCode = prefs.getString('branchCode').toString();
        chatList = await whatsAppConfigurationControllerApi.fetchAllMessages(branchCode, 30);

      }else{
        print('No booking found, useless to retrieve chat data');
      }

    }catch(e){
      print('chat data set size : ${chatList!.length.toString()}');
      print('Error: ' + e.toString());
    }

    notifyListeners();
  }



  Future<void> sendWhatsAppMessage(String phone, ChatMessage chatMessage) async {
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

  setNewWhatsAppConfigurationDTO(WhatsAppConfigurationDTO updatedWhatsAppConfigurationDTO) {
    currentWhatsAppConfigurationDTO = updatedWhatsAppConfigurationDTO;
    notifyListeners();
  }
}