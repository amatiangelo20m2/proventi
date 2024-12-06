import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  final Map<int, Widget> _segments = const <int, Widget>{
    0: Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_scanner),
          Text('Scan QR'),
        ],
      ),
    ),
    1: Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.key),
          Text('Usa codice'),
        ],
      ),
    ),
  };

  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white, // Example color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoSegmentedControl<int>(
              borderColor: globalGold,
              selectedColor: Colors.black,
              children: _segments,
              onValueChanged: (int value) {
                setState(() {
                  _selectedSegment = value;
                });
              },
              groupValue: _selectedSegment,

            ),
            Consumer<CommunicationStateManager>(
              builder: (BuildContext context,
                  CommunicationStateManager communicationStateManager,
                  Widget? child) {
                return _selectedSegment == 0
                    ? QrCodeWidgetScannerWhatsApp(base64ImageString: communicationStateManager.currentWhatsAppConfigurationDTO?.qrCode!)
                    : const PairedCodeWhatsApp();
              },
            ),
            const Text('',
                style: TextStyle(fontSize: 7)),
          ],
        ),
      ),
    );
  }
}
