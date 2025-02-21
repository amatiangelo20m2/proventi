import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proventi/app/custom_widgets/whatsapp/whatsapp_chat_state_manager.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';

import '../../../api/restaurant_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';

class DashChatCustomized20 extends StatefulWidget {
  const DashChatCustomized20({super.key, required this.customerDTO});

  final CustomerDTO customerDTO;

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
      user2Id: '${widget.customerDTO.prefix!}${widget.customerDTO.phone!}@c.us',
      fetchMessages: () async {
        // Define the function to fetch messages from the API
        final communicationStateManager = context.read<CommunicationStateManager>();
        final chatMessagesResponse = await communicationStateManager.retrieveChatSpecificWithUserData(
          widget.customerDTO.prefix! + widget.customerDTO.phone!,
        );


        print(chatMessagesResponse);

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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(
                color: Colors.white
              ),
              backgroundColor: blackDir,
              actions: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: () {
                  Navigator.of(context).pop();
                },),
              )],
              title: Row(
                children: [
                  ProfileImage(
                      branchCode: widget.customerDTO.branchCode!,
                      avatarRadious: 20,
                      customer: widget.customerDTO,
                      allowNavigation: false),
                  Text(' ${widget.customerDTO.firstName!} '
                      '${widget.customerDTO.lastName!}', 
                    style: const TextStyle(color: Colors.white, fontSize: 15),),

                ],
              ),
            ),
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/whatsappback.jpg', // Replace with your image path
                    fit: BoxFit.scaleDown,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                stateManager.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : DashChat(
                  inputOptions: InputOptions(
                    inputDecoration: defaultInputDecoration(

                      hintText: 'Scrivi un messaggio...', // Override the hintText here
                    ),
                  ),
                  messageListOptions: MessageListOptions(

                    dateSeparatorFormat: DateFormat('EEEE dd MMMM yyyy HH:mm', 'it_IT'),
                  ),
                  messageOptions: MessageOptions(
                    currentUserContainerColor: Colors.green.withAlpha(200),
                    containerColor: blackDir,
                    currentUserTextColor: Colors.white,
                    textColor: Colors.white,
                  ),
                  currentUser: ChatUser(id: chatStateManager.user1Id),
                  messages: stateManager.chatMessages.toList(),
                  onSend: (ChatMessage message) {
                    stateManager.sendNewMessage(message);
                  },
                ),
              ],
            )
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
