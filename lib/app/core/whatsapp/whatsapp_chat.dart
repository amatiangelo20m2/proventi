import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:proventi/app/core/whatsapp/whatsapp_chat_state_manager.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:provider/provider.dart';

import '../../../api/restaurant_client/lib/api.dart';
import '../../../global/style.dart';
import '../../../state_manager/communication_state_manager.dart';

class DashChatCustomized20 extends StatefulWidget {
  const DashChatCustomized20({super.key, required this.bookingDTO});

  final BookingDTO bookingDTO;

  @override
  State<DashChatCustomized20> createState() => _DashChatCustomized20State();
}

class _DashChatCustomized20State extends State<DashChatCustomized20> {
  late ChatStateManager chatStateManager;

  @override
  void initState() {
    super.initState();

    // Initialize the chat state manager
    chatStateManager = ChatStateManager(
      user1Id: '1', // Replace with the actual user1 ID
      user2Id: widget.bookingDTO.customer!.prefix! + widget.bookingDTO.customer!.phone! + '@c.us',
      fetchMessages: () async {
        // Define the function to fetch messages from the API
        final communicationStateManager = context.read<CommunicationStateManager>();
        final chatMessagesResponse = await communicationStateManager.retrieveChatSpecificWithUserData(
          widget.bookingDTO.customer!.prefix! + widget.bookingDTO.customer!.phone!,
        );

        if (chatMessagesResponse != null) {
          return chatMessagesResponse.data
              .map((e) => ChatMessage(
            text: e.body ?? '',
            user: e.from == chatStateManager.user2Id
                ? ChatUser(id: chatStateManager.user2Id)
                : ChatUser(id: chatStateManager.user1Id),
            createdAt: DateTime.fromMillisecondsSinceEpoch(e.timestamp ?? 0),
          ))
              .toList();
        }
        return [];
      },
      sendMessage: (ChatMessage message) async {
        // Define the function to send a message via API
        final communicationStateManager = context.read<CommunicationStateManager>();
        await communicationStateManager.sendWhatsAppMessage(
          chatStateManager.user2Id.replaceAll('@c.us', ''),
          message,
        );
      },
    );

    chatStateManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatStateManager>.value(
      value: chatStateManager,
      child: Consumer<ChatStateManager>(
        builder: (context, stateManager, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white
              ),

              backgroundColor: Colors.black,
              title: Text('${widget.bookingDTO.customer!.firstName!} ${widget.bookingDTO.customer!.lastName!}', style: const TextStyle(color: Colors.white, fontSize: 15),),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileImage(
                      branchCode: widget.bookingDTO.branchCode!,
                      avatarRadious: 20,
                      customer: widget.bookingDTO.customer!,
                      allowNavigation: false),
                )
              ],
            ),
            body: stateManager.isLoading
                ? const Center(child: CircularProgressIndicator())
                : DashChat(

              messageOptions: const MessageOptions(
                currentUserContainerColor: Color(0xFF005246),
                containerColor: Color(0XFF363638),
                currentUserTextColor: Colors.white,
                textColor: Colors.white,
              ),
              currentUser: ChatUser(id: chatStateManager.user1Id),
              messages: stateManager.chatMessages.toList(),
              onSend: (ChatMessage message) {
                stateManager.sendNewMessage(message);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    chatStateManager.dispose();
    super.dispose();
  }
}
