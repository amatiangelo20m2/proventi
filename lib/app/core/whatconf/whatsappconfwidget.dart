import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../api/communication_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';

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
          CommunicationStateManager communicationStateManager,
          Widget? child) {
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
                onPressed: () {},
                backgroundColor: Colors.red,
                child: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: 30,
                ),
              );
            } else if (snapshot.hasData) {
              // Display the image in an avatar
              WhatsAppConfigurationDTO config =
              snapshot.data!;
              return FloatingActionButton(
                mini: true,
                heroTag: "btn1",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        title: const Text(
                          "WhatsApp Configuration",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              // Display profile image if photoUrl is available
                              if (config.photoUrl != null)
                                Center(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        config.photoUrl!),
                                    radius: 40,
                                  ),
                                ),
                              const SizedBox(height: 10),

                              // Display configuration details with conditional null-checks
                              _buildConfigItem(
                                  "ID", config.id?.toString()),
                              _buildConfigItem(
                                  "Branch Code", config.branchCode),
                              _buildConfigItem(
                                  "Phone", config.phone),
                              _buildConfigItem("API Instance ID",
                                  config.waApiInstanceId),
                              _buildConfigItem(
                                  "State", config.waApiState!.value),
                              _buildConfigItem(
                                  "Last Error", config.lastError),
                              _buildConfigItem(
                                  "Creation Date",
                                  config.creationDate != null
                                      ? DateFormat(
                                      'dd MMM yyyy, HH:mm')
                                      .format(
                                      config.creationDate!)
                                      : null),
                              _buildConfigItem(
                                  "QR Code", config.qrCode),
                              _buildConfigItem("Display Name",
                                  config.displayName),
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
                backgroundColor: Colors.green,
                child: const Icon(
                  FontAwesomeIcons.whatsapp,
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
