import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/communication_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';
import '../home_screen.dart';

class CriticalWhatsAppConfigurationWidget extends StatefulWidget {
  const CriticalWhatsAppConfigurationWidget({super.key});

  @override
  State<CriticalWhatsAppConfigurationWidget> createState() => _CriticalWhatsAppConfigurationWidgetState();
}

class _CriticalWhatsAppConfigurationWidgetState extends State<CriticalWhatsAppConfigurationWidget> {

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Lottie.asset('assets/lotties/danger.json', height: 150),
                  const Text('Configurazione non trovata o compromessa in modo critico.', style: TextStyle(fontSize: 15, color: Colors.white)),
                  const Text('Premi il tasto per fare un reset completo.', style: TextStyle(fontSize: 10, color: Colors.white)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  width: 400,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });
                        try{
                          final prefs = await SharedPreferences.getInstance();
                          String branchCode = prefs.getString('branchCode').toString();
                          await communicationStateManager.whatsAppConfigurationControllerApi.deleteConfWaApiWithHttpInfo(branchCode);
                          await Future.delayed(const Duration(seconds: 2));
                          WhatsAppConfigurationDTO? whatsAppConfDTO
                          = await communicationStateManager.whatsAppConfigurationControllerApi.createConfWaApi(branchCode);
                          if(whatsAppConfDTO != null){
                            await Future.delayed(const Duration(seconds: 2));
                            whatsAppConfDTO = await communicationStateManager.whatsAppConfigurationControllerApi.retrieveQr(branchCode)!;
                            setState(() {
                              _loading = false;
                            });
                            Fluttertoast.showToast(
                              msg: "Ho eseguito un ripristino della configurazione, prova ora a connettere il numero whatsapp tramite il qr o il codice",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: globalGold,
                              timeInSecForIosWeb: 8,
                              fontSize: 18.0,
                            );

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const HomeScreen(pageIndex: 0,)),
                            );
                          }else{
                            setState(() {
                              _loading = false;
                            });
                          }


                        }catch(e){
                          Fluttertoast.showToast(
                            msg: "Sto ancora riscontrando problemi, prova a chiudere l\'app e riprovare fra 2-3 minuti",
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.red,
                            timeInSecForIosWeb: 8,
                            fontSize: 18.0,
                          );
                          setState(() {
                            _loading = false;
                          });
                        }





                      }, child: _loading ? Column(
                        children: [
                          Text('Attendi per favore, sto eseguendo il ripristino..', style: TextStyle(fontSize: 20, color: Colors.black),),
                          CupertinoActivityIndicator(
                                            color: globalGold,
                                            radius: 25,
                                          ),
                        ],
                      ) : Text('RESET CONFIGURAZIONE', style: TextStyle(fontSize: 15, color: Colors.white),)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
