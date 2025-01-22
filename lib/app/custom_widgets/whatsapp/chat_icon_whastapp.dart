import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/custom_widgets/whatsapp/whatsapp_chat.dart';
import 'package:provider/provider.dart';

import '../../../api/communication_client/lib/api.dart';
import '../../../api/restaurant_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';
import 'db/message_helper.dart';
import 'db/model/message_model.dart';

class ChatIconWhatsApp extends StatefulWidget {
  const ChatIconWhatsApp({super.key, required this.booking, required this.iconSize});

  final BookingDTO booking;
  final int iconSize;
  @override
  State<ChatIconWhatsApp> createState() => _ChatIconWhatsAppState();
}

class _ChatIconWhatsAppState extends State<ChatIconWhatsApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communication, Widget? child) {
        return GestureDetector(
          onTap: () async {

            if (await communication.checkIfChatsContainCurrentNumberWithUnreadChats(widget.booking)) {
              if (communication.chatList!.where((element) => element.fromNumber == '${widget.booking.customer!.prefix}${widget.booking.customer!.phone}@c.us').isNotEmpty) {
                AllChatListDataDTO chatListDataDTO = communication.chatList!.where((element) => element.fromNumber == '${widget.booking.customer!.prefix}${widget.booking.customer!.phone}@c.us').first;
                if (chatListDataDTO.unreadCount! > 0 && !chatListDataDTO.fromMe!) {
                  await DatabaseWhatsAppMessageHelper.instance.insertMessageId(MessageModel(messageId: chatListDataDTO.timestamp!.toString()));
                  setState(() {

                  });
                }
              }
            }
            showCupertinoModalBottomSheet(
              expand: true,
              elevation: 10,
              context: context,
              builder: (BuildContext context) {
                return DashChatCustomized20(bookingDTO: widget.booking);
              },
            );
          },
          child: FutureBuilder<bool>(
            future: communication.checkIfChatsContainCurrentNumberWithUnreadChats(widget.booking),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Icon(Icons.error, color: Colors.red);
              } else if (snapshot.hasData && snapshot.data == true) {
                return Stack(
                  children: [
                    Lottie.asset('assets/lotties/whatsapp.json', width: widget.iconSize.toDouble()),
                    const Positioned(right: 0, child: Icon(Icons.circle, size: 14, color: Colors.red)),
                  ],
                );
              } else {
                return const Icon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 25);
              }
            },
          ),
        );
      },
    );
  }
}