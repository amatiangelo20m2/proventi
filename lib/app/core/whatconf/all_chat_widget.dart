import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../api/communication_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';
import '../../custom_widgets/whatsapp/whatsapp_chat.dart';
import 'link_whatsapp_component.dart';

class AllChatWidget extends StatefulWidget {
  const AllChatWidget({super.key});

  @override
  State<AllChatWidget> createState() => _AllChatWidgetState();
}

class _AllChatWidgetState extends State<AllChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {

        if (communicationStateManager.currentWhatsAppConfigurationDTO?.waApiState ==
            WhatsAppConfigurationDTOWaApiStateEnum.PRONTA) {
          return _buildChatWidget(communicationStateManager);
        }
        // State: QR
        else if (communicationStateManager.currentWhatsAppConfigurationDTO?.waApiState ==
            WhatsAppConfigurationDTOWaApiStateEnum.QR) {
          return Center(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LinkWhatsAppComponent.routeName);
              },
              icon: Icon(CupertinoIcons.qrcode_viewfinder, color: Colors.grey.shade800, size: 230),
            ),
          );
        }
        // State: Other
        else {
          return Center(
            child: IconButton(
              onPressed: (){},
              icon: const Icon(
                FontAwesomeIcons.squareWhatsapp,
                size: 36,
                color: Colors.red,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildChatWidget(CommunicationStateManager communicationStateManager) {
    return ListView.builder(
      itemCount: communicationStateManager.chatList!.length,
      itemBuilder: (context, index) {
        final chat = communicationStateManager.chatList![index];
        final firstLine = chat.body?.split('\n').first ?? 'No message';
        final timestamp = DateTime.fromMillisecondsSinceEpoch(chat.timestamp!);
        final now = DateTime.now();
        final isToday = now.year == timestamp.year && now.month == timestamp.month && now.day == timestamp.day;
        final timeFormat = isToday ? DateFormat('HH:mm') : DateFormat('dd/MM/yyyy');
        final formattedTime = timeFormat.format(timestamp);

        return ListTile(
          leading: ProfileImage(
            branchCode: communicationStateManager.currentWhatsAppConfigurationDTO!.branchCode!,
            avatarRadious: 25,
            customer: CustomerDTO(
              prefix: chat.fromNumber!.substring(0, 2),
              phone: chat.fromNumber!.substring(2).replaceAll('@c.us', ''),
              lastName: '',
              firstName: chat.name,
            ),
            allowNavigation: false,
          ),
          title: Text(
            chat.name ?? 'Unknown',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstLine,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
              Divider(color: Colors.grey.shade100,)
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedTime,
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
              if (chat.unreadCount != null && chat.unreadCount! > 0)
                CircleAvatar(
                  backgroundColor: Colors.blueAccent.withAlpha(200),
                  radius: 12,
                  child: Text(
                    chat.unreadCount.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
          onTap: () {
            showCupertinoModalBottomSheet(
              expand: true,
              elevation: 10,
              context: context,
              builder: (BuildContext context) {
                return DashChatCustomized20(customerDTO: CustomerDTO(
                  firstName: chat.name,
                  lastName: '',
                  prefix: chat.fromNumber!.substring(0, 2),
                  phone: chat.fromNumber!.substring(2).replaceAll('@c.us', ''),
                  branchCode: communicationStateManager.currentWhatsAppConfigurationDTO!.branchCode!,
                ));
              },
            );
          },
        );
      },
    );
  }
}