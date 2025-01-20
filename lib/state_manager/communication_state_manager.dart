import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart' as RESTAURANT_CLIENT;
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/communication_client/lib/api.dart';
import '../app/custom_widgets/whatsapp/db/message_helper.dart';
import '../environment_config.dart';

class CommunicationStateManager extends ChangeNotifier {

  final GlobalKey<NavigatorState> navigatorKey;
  late ApiClient _communicationClient;

  late WhatsAppConfigurationControllerApi whatsAppConfigurationControllerApi;

  CommunicationStateManager(this.navigatorKey){
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
  static const int _apiCallIntervalSeconds = 30;
  WhatsAppConfigurationDTO? currentWhatsAppConfigurationDTO;
  Future<WhatsAppConfigurationDTO?> retrieveWaApiConfStatus() async {
    final currentTime = DateTime.now();
    // Check if 60 seconds have passed since the last API call
    if (_lastApiCallTime != null && currentTime.difference(_lastApiCallTime!).inSeconds < _apiCallIntervalSeconds) {
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
  Future<void> retrieveChatData() async {
    try {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        print('Navigator context is null');
        return;
      }
      RestaurantStateManager restaurantStateManager = Provider.of<RestaurantStateManager>(context, listen: false);
      if(restaurantStateManager.allBookings!.isNotEmpty){
        try {
          String branchCode = prefs.getString('branchCode').toString();
          //print('Retrieve all chat list for branch code $branchCode');

          // Log the request details
          //print('Making API call to: ${_communicationClient.basePath}/api/wsapicontroller/fetchallmessages/$branchCode/30');

          chatList = await whatsAppConfigurationControllerApi.fetchAllMessages(branchCode, 5);
          //print('API call successful, chat list retrieved' + chatList!.toString());
        } catch (e) {
          print('Error -> : ' + e.toString());
        }
      }else{
        print('No booking found, useless to retrieve chat data');
      }

    }catch(e){
      print('chat data set size : ${chatList!.length.toString()}');
      print('Error -> : ' + e.toString());
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


  Future<bool> checkIfChatsContainCurrentNumberWithUnreadChats(RESTAURANT_CLIENT.BookingDTO booking) async {

    List<String> listMessageAlreadyRead = await DatabaseWhatsAppMessageHelper.instance.fetchAllMessageIdsRead();

      if(chatList!.where((element) => element.fromNumber
          == '${booking.customer!.prefix}${booking.customer!.phone}@c.us').isNotEmpty) {
        AllChatListDataDTO chatListDataDTO = chatList!.where((element) => element.fromNumber == '${booking.customer!.prefix}${booking.customer!.phone}@c.us').first;
        if(chatListDataDTO.unreadCount! > 0
            && !chatListDataDTO.fromMe!
            && !listMessageAlreadyRead.contains(chatListDataDTO.timestamp!.toString())){
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