import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../api/communication_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';
import '../../custom_widgets/profile_image.dart';

class DashChatCustomized20 extends StatefulWidget {
  const DashChatCustomized20({super.key, required this.bookingDTO});

  final BookingDTO bookingDTO;

  @override
  State<DashChatCustomized20> createState() => _DashChatCustomized20State();
}

class _DashChatCustomized20State extends State<DashChatCustomized20> {
  // Define the current user (User 1)
  ChatUser user1 = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  // Define the other user (User 2)
  late ChatUser user2;
  List<ChatMessage> chatMessages = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    // Initialize user2 based on the booking information
    user2 = ChatUser(
      id: widget.bookingDTO.customer!.prefix! + widget.bookingDTO.customer!.phone! + '@c.us',
      firstName: widget.bookingDTO.customer!.firstName!,
      lastName: widget.bookingDTO.customer!.lastName!,
    );

    // Fetch the chat messages when the screen is loaded
    _loadChatMessages();
  }

  // Fetch chat messages in initState
  Future<void> _loadChatMessages() async {
    try {
      final communicationStateManager = context.read<CommunicationStateManager>();
      final chatMessagesResponse = await communicationStateManager.retrieveChatSpecificWithUserData(
        widget.bookingDTO.customer!.prefix! + widget.bookingDTO.customer!.phone!,
      );

      setState(() {
        if (chatMessagesResponse != null && chatMessagesResponse.data.isNotEmpty) {
          chatMessages = _mapMessages(chatMessagesResponse.data.toList().reversed.toList());
          isLoading = false;
          hasError = false;
        } else {
          hasError = true;
          errorMessage = 'No messages found.';
          isLoading = false;
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Error loading messages: $e';
      });
    }
  }

  // Map API response data to DashChat's ChatMessage
  List<ChatMessage> _mapMessages(List<MessageDataDTO> messageDataList) {
    List<ChatMessage> list = [];
    messageDataList.forEach((element) {
      bool isFromUser2 = element.from == user2.id;

      list.add(ChatMessage(
        text: element.body ?? '',
        user: isFromUser2 ? user2 : user1,
        createdAt: DateTime.fromMillisecondsSinceEpoch(element.timestamp ?? 0),
        isMarkdown: false, // No markdown, you can enable this if needed
      ));
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.grey[900],
            surfaceTintColor: Colors.grey[900],
            title: Text(
              '${widget.bookingDTO.customer!.firstName!} ${widget.bookingDTO.customer!.lastName!}',
              style: const TextStyle(fontSize: 15, color: CupertinoColors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ProfileImage(prefix: widget.bookingDTO.customer!.prefix!,
                  phone: widget.bookingDTO.customer!.phone!,
                  branchCode: widget.bookingDTO.branchCode!,
                  avatarRadious: 30,
                ),
              ),
            ],
          ),
          body: isLoading
              ? Center(child: CupertinoActivityIndicator(color: globalGold, radius: 15,)) // Loading indicator
              : hasError
              ? Center(child: Text(errorMessage)) // Error message
              : Container(
            color: Colors.grey[900],
                child: DashChat(
                  messageOptions: MessageOptions(
                    currentUserContainerColor: globalGoldDark,
                    containerColor: Colors.grey[300]!,
                    currentUserTextColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  currentUser: user1,
                  onSend: (ChatMessage message) {
                    communicationStateManager.sendWhatsAppMessage(
                      user2.id.replaceAll('@c.us', ''),
                      ChatMessage(
                        text: message.text,
                        user: message.user,
                        createdAt: DateTime.now(),
                      ),
                    );
                  },
                  messages: chatMessages.reversed.toList(),
                ),
              ),
        );
      },

    );
  }
}
