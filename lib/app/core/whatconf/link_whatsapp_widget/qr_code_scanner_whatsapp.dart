import 'dart:async';
import 'dart:convert'; // Required for base64Decode
import 'dart:typed_data'; // Required for Uint8List
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/communication_client/lib/api.dart';
import '../../../../global/style.dart';
import '../../home_screen.dart';

class QrCodeWidgetScannerWhatsApp extends StatefulWidget {
  const QrCodeWidgetScannerWhatsApp({super.key, required this.base64ImageString});

  final String? base64ImageString;
  @override
  State<QrCodeWidgetScannerWhatsApp> createState() => _QrCodeWidgetScannerWhatsAppState();
}

class _QrCodeWidgetScannerWhatsAppState extends State<QrCodeWidgetScannerWhatsApp> {
  WhatsAppConfigurationDTO? whatsAppConfigurationDTO;
  Timer? _pollingTimer;

  void startPolling() {
    _pollingTimer?.cancel(); // Cancel any existing timer
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      pollForUpdates();
    });
  }

  Future<void> pollForUpdates() async {
    final prefs = await SharedPreferences.getInstance();
    String branchCode = prefs.getString('branchCode').toString();

    WhatsAppConfigurationDTO? updatedWhatsAppConfigurationDTO = await Provider.of<CommunicationStateManager>(context, listen: false).whatsAppConfigurationControllerApi.retrieveWaApiConfStatus(branchCode);

    if (updatedWhatsAppConfigurationDTO != null && updatedWhatsAppConfigurationDTO.waApiState == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA) {
      await Provider.of<CommunicationStateManager>(context, listen: false).setNewWhatsAppConfigurationDTO(updatedWhatsAppConfigurationDTO);
      _pollingTimer?.cancel();
      Fluttertoast.showToast(
        msg: "😎 Numero what'sapp collegato con successo, ora puoi mandare messaggi",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: globalGold,
        timeInSecForIosWeb: 5,
        fontSize: 18.0,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen(pageIndex: 0)),
      );
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => startPolling());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.base64ImageString!.isEmpty) {
      return const Text("Nessun codice qr disponibile");
    }

    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
        final RegExp regex = RegExp(r'data:image\/[a-zA-Z]+;base64,');

        // Decode the base64 string into bytes
        Uint8List imageBytes;
        try {
          imageBytes = base64Decode(widget.base64ImageString!.replaceAll(regex, ''));
        } catch (e) {
          return const Text("Il codice qr risulta essere corrotto");
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(
              imageBytes,
              fit: BoxFit.cover, // Adjust as needed
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: LinearProgressIndicator(
                color: blackDir,
              ),
            ),
            const Text('Scannerizza il QR code per collegare numero whatsapp', style: TextStyle(fontSize: 7)),
          ],
        );
      },
    );
  }
}