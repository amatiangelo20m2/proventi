import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:proventi/api/restaurant_client/lib/api.dart'; // Make sure the import is correct
import '../../../api/communication_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';

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

  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();

    // Initialize user2 based on the booking information
    user2 = ChatUser(
      id: widget.bookingDTO.customer!.prefix! + widget.bookingDTO.customer!.phone! + '@c.us',
      firstName: widget.bookingDTO.customer!.firstName!,
      lastName: widget.bookingDTO.customer!.lastName!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey[900],
        surfaceTintColor: Colors.grey[900],
        title: Text('${widget.bookingDTO.customer!.firstName!} ${widget.bookingDTO.customer!.lastName!}',
          style: TextStyle(fontSize: 15, color: CupertinoColors.white),
        ),
      ),
      body: Consumer<CommunicationStateManager>(
        builder: (context, communicationStateManager, child) {
          // Trigger the API call to retrieve chat messages
          Future<ChatMessagesResponseDTO?> chatMessagesFuture =
          communicationStateManager.retrieveChatSpecificWithUserData(
              widget.bookingDTO.customer!.prefix! + widget.bookingDTO.customer!.phone!);

          return FutureBuilder<ChatMessagesResponseDTO?>(
            future: chatMessagesFuture, // Use the future from the Consumer
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loading spinner while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Show error message if there is an error
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // Map the data to ChatMessages and show it in DashChat widget
                List<ChatMessage> mappedMessages = mapMessages(snapshot.data!.data.toList().reversed.toList());

                return Container(
                  color: Colors.grey[900],
                  child: RefreshIndicator(

                    onRefresh: () async {
                      setState(() {

                      });
                    },
                    child: DashChat(
                      currentUser: user1,
                      onSend: (ChatMessage message) {
                        communicationStateManager.sendWhatsAppMessage(message.text, user2.id.replaceAll('@c.us', ''));
                      },
                      messages: mappedMessages.reversed.toList(),
                    ),
                  ),
                );
              } else {
                // Show message if no data is returned
                return Center(child: Text('No messages found.'));
              }
            },
          );
        },
      ),
    );
  }

  // Map API response data to DashChat's ChatMessage
  List<ChatMessage> mapMessages(List<MessageDataDTO> messageDataList) {
    List<ChatMessage> list = [];
    messageDataList.forEach((element) {
      bool isFromUser2 = element.from == user2.id;

      // Add message to the list with appropriate alignment
      list.add(ChatMessage(
        text: element.body ?? '',
        user: isFromUser2 ? user2 : user1, // Set the user for the message
        createdAt: DateTime.fromMillisecondsSinceEpoch(element.timestamp ?? 0),
        isMarkdown: false, // No markdown, you can enable this if needed

      ));
    });

    return list;
  }

  // Function to add a message to the chat (if needed)
  void addMessage(ChatMessage message) {
    setState(() {
      messages.add(ChatMessage(
        text: message.text,
        user: message.user,
        createdAt: DateTime.now(),
      ));
    });
  }
}
