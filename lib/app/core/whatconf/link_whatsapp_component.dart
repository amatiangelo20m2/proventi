import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'link_whatsapp_widget/paired_code_whatsapp.dart';
import 'link_whatsapp_widget/qr_code_scanner_whatsapp.dart';

class LinkWhatsAppComponent extends StatefulWidget {
  static const String routeName = '/link-whatsapp';

  const LinkWhatsAppComponent({super.key});

  @override
  _LinkWhatsAppComponentState createState() => _LinkWhatsAppComponentState();
}

class _LinkWhatsAppComponentState extends State<LinkWhatsAppComponent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Collega numero What\'s app', style: TextStyle(color: Colors.white, fontSize: 15),),
          backgroundColor: elegantGreen,
          surfaceTintColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade800,
            tabs: const [
              Tab(
                icon: Icon(Icons.qr_code_scanner),
                text: 'Scan QR',
              ),
              Tab(
                icon: Icon(Icons.key),
                text: 'Usa codice',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<CommunicationStateManager>(
              builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
                return QrCodeWidgetScannerWhatsApp(base64ImageString: communicationStateManager.currentWhatsAppConfigurationDTO?.qrCode);
              },
            ),
            const PairedCodeWhatsApp(),
          ],
        ),
      ),
    );
  }
}