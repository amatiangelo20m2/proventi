import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proventi/api/communication_client/lib/api.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

import '../home_screen.dart';

class InstanceDetailsWhenPronta extends StatelessWidget {
  const InstanceDetailsWhenPronta({super.key});

  @override
  Widget build(BuildContext context) {


    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
        WhatsAppConfigurationDTO configuration = communicationStateManager.currentWhatsAppConfigurationDTO!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [

                  Center(child: Text(' ${configuration.displayName ?? 'N/A'}', style: const TextStyle(fontSize: 20, color: Colors.white))),
                  if (configuration.photoUrl != null && configuration.photoUrl!.isNotEmpty)
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 8),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            configuration.photoUrl!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ),


              Column(
                children: [
                  const Center(child: Text('Numero collegato', style: TextStyle(fontSize: 7, color: Colors.grey))),
                  Center(child: Text(' ${configuration.phone ?? 'N/A'}', style: const TextStyle(fontSize: 17, color: Colors.white))),

                  const Center(child: Text('Codice attività associata', style: TextStyle(fontSize: 7, color: Colors.grey))),
                  Center(child: Text(' ${configuration.branchCode ?? 'N/A'}', style: const TextStyle(fontSize: 17, color: Colors.white))),

                  const Center(child: Text('Identificativo istanza', style: TextStyle(fontSize: 7, color: Colors.grey))),
                  Center(child: Text(' ${configuration.waApiInstanceId ?? 'N/A'}', style: const TextStyle(fontSize: 17, color: Colors.white))),

                  const Center(child: Text('Stato', style: TextStyle(fontSize: 7, color: Colors.grey))),
                  Card(color: blackDir.withAlpha(180), elevation: 10, child: Center(child: Text(' ${configuration.waApiState.toString() ?? 'N/A'}', style: TextStyle(fontSize: 17, color: Colors.blueAccent)))),
                  
                  const SizedBox(height: 40,)
                ],
              ),
              Center(
                child: CupertinoButton(
                  color: elegantRed,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Conferma'),
                          content: const Text('Sei sicuro di voler disconnettere il numero?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Response responseDeleteConf = await communicationStateManager.whatsAppConfigurationControllerApi
                                    .deleteConfWaApiWithHttpInfo(configuration.branchCode!);
                                if(responseDeleteConf.statusCode == 204){

                                  Fluttertoast.showToast(
                                    msg: "Hai eliminato il numero whatsapp, ora non potrai ne ricevere ne inviare messaggi",
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.redAccent,
                                    timeInSecForIosWeb: 5,
                                    fontSize: 18.0,
                                  );
                                  communicationStateManager.retrieveWaApiConfStatus();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => const HomeScreen(pageIndex: 0,)),
                                  );

                                }
                              },
                              child: const Text('Si'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Disconnetti Numero'.toUpperCase(), style: TextStyle(color: Colors.white, fontFamily: globalFontFamily, fontSize: 13)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Connesso da ${italianDateFormatWithTime.format(configuration.creationDate!)}', style: const TextStyle(fontSize: 7, color: Colors.grey)),
              ),

            ],
          ),
        );
      },
    );
  }
}
