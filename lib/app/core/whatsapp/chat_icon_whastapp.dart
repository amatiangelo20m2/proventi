import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/whatsapp/whatsapp_chat.dart';
import 'package:provider/provider.dart';

import '../../../api/restaurant_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';

class ChatIconWhatsApp extends StatefulWidget {
  const ChatIconWhatsApp({super.key, required this.booking});

  final BookingDTO booking;
  @override
  State<ChatIconWhatsApp> createState() => _ChatIconWhatsAppState();
}

class _ChatIconWhatsAppState extends State<ChatIconWhatsApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context,
          CommunicationStateManager communication,
          Widget? child) {
        return IconButton(onPressed: () {
          showCupertinoModalBottomSheet(
            expand: true,
            elevation: 10,
            context: context,
            builder: (BuildContext context) {
              return DashChatCustomized20(bookingDTO: widget.booking,);
            },
          );
        }, icon: Stack(children: [
          if(!communication.checkIfChatsContainCurrentNumberWithUnreadChats(widget.booking))
            const Icon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 25,),
          if(communication.checkIfChatsContainCurrentNumberWithUnreadChats(widget.booking))
            Lottie.asset('assets/lotties/whatsapp.json', width: 40),
          if(communication.checkIfChatsContainCurrentNumberWithUnreadChats(widget.booking))
            const Positioned(right: 0, child: Icon(Icons.circle, size: 14, color: Colors.red,))
        ]),
        );
      },
    );
  }
}
