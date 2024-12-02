import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../api/communication_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';
import 'image_from_base64/image_from_base64.dart';

class WhatsAppConfWidget extends StatelessWidget {
  const WhatsAppConfWidget({super.key});


  Widget _buildConfigItem(String label, String? value) {
    return value != null && value.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context,
          CommunicationStateManager communicationStateManager, Widget? child) {
        return FutureBuilder<WhatsAppConfigurationDTO?>(
          future: communicationStateManager
              .retrieveWaApiConfStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const SizedBox(
                height: 0,
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return FloatingActionButton(
                mini: true,
                heroTag: "btn1",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        title: const Text(
                          "Stato What's App WaApi",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Errore durante il recupero della configurazione",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Errore: ${snapshot.error}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(),
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Colors.red,
                child: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: 30,
                ),
              );
            } else if (snapshot.hasData) {
              // Display the image in an avatar
              WhatsAppConfigurationDTO config = snapshot.data!;
              return FloatingActionButton(
                mini: true,
                heroTag: "btn1",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),

                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              // Display profile image if photoUrl is available
                              if (config.photoUrl != null)
                                if( config.waApiState!
                                    == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                                Center(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        config.photoUrl!),
                                    radius: 40,
                                  ),
                                ),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                              _buildConfigItem("Nome su istanza collegata",
                                  config.displayName),
                              const SizedBox(height: 10),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                              _buildConfigItem(
                                  "Codice Attività: ", config.branchCode),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                              _buildConfigItem(
                                  "Cellulare collegato", config.phone),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                              _buildConfigItem("WaApi Id Istanza",
                                  config.waApiInstanceId),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                              _buildConfigItem(
                                  "STATO", config.waApiState!.value),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                              _buildConfigItem(
                                  "Last Error", config.lastError),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA)
                              _buildConfigItem(
                                  "Creation Date",
                                  config.creationDate != null
                                      ? DateFormat(
                                      'dd MMM yyyy, HH:mm')
                                      .format(
                                      config.creationDate!)
                                      : null),
                              if( config.waApiState!
                                  == WhatsAppConfigurationDTOWaApiStateEnum.QR)
                                buildImageFromBase64(config.qrCode)

                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(),
                            child: const Text("Chiudi"),
                          ),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Colors.green,
                child: Icon(
                  config.waApiState == WhatsAppConfigurationDTOWaApiStateEnum.QR
                      ? CupertinoIcons.qrcode : FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: 30,
                ),
              );
            } else {
              // Handle the case where no data is returned
              return FloatingActionButton(
                mini: true,
                heroTag: "btn1",
                onPressed: () {},
                backgroundColor: Colors.red,
                child: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: 30,
                ),
              );
            }
          },
        );
      },
    );
  }
}
