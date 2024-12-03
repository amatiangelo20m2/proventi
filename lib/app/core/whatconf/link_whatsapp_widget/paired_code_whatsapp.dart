import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/communication_client/lib/api.dart';
import '../../main_screen.dart';

class PairedCodeWhatsApp extends StatefulWidget {
  const PairedCodeWhatsApp({super.key});

  @override
  State<PairedCodeWhatsApp> createState() => _PairedCodeWhatsAppState();
}

class _PairedCodeWhatsAppState extends State<PairedCodeWhatsApp> {

  Country _currentSelectedCountry = Country.parse('IT');
  final TextEditingController _prefixController = TextEditingController(text: '39');
  final TextEditingController _phoneController = TextEditingController();

  WhatsAppConfigurationDTO? whatsAppConfigurationDTO;
  Timer? _pollingTimer;

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
        return Column(
          children: [
            if(whatsAppConfigurationDTO == null)Row(
              children: [
                CupertinoButton(onPressed: (){
                  showCountryPicker(
                    context: context,
                    //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                    exclude: <String>['KN', 'MF'],
                    favorite: <String>['IT'],
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        _currentSelectedCountry = country;
                        _prefixController.text = _currentSelectedCountry.countryCode;
                      });
                    },
                    moveAlongWithKeyboard: false,
                    countryListTheme: CountryListThemeData(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      inputDecoration: InputDecoration(
                        labelText: 'Ricerca nazione',

                        prefixIcon: const Icon(CupertinoIcons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                      searchTextStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  );
                }, child: Text('${_currentSelectedCountry.flagEmoji} '
                    '+${_currentSelectedCountry.phoneCode}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey[900]),)),
                Expanded(
                  child: CupertinoTextField(
                    keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                    controller: _phoneController,
                    placeholder: "Cellulare",
                    clearButtonMode: OverlayVisibilityMode.always,
                    style: const TextStyle(fontSize: 13),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EasyButton(
                    type: EasyButtonType.elevated,
                    idleStateWidget: const Text(
                      'Dammi il codice',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    loadingStateWidget: const CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                    useWidthAnimation: true,
                    useEqualLoadingStateWidgetDimension: true,
                    width: 150.0,
                    height: 40.0,
                    borderRadius: 12.0,
                    elevation: 1.0,
                    contentGap: 6.0,
                    buttonColor: globalGold,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      final prefs = await SharedPreferences.getInstance();
                      String branchCode = prefs.getString('branchCode').toString();
                      if(_phoneController.text == ''){
                        Fluttertoast.showToast(
                          msg: "Inserisci un numero di telefono valido",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.red,
                          fontSize: 18.0,
                        );
                      }else{
                        print('Retrieve pairing code$branchCode${_prefixController.text}${_phoneController.text}');
                        whatsAppConfigurationDTO = await communicationStateManager
                            .whatsAppConfigurationControllerApi
                            .retrievePairingCodeWaApi(branchCode,
                            _prefixController.text,
                            _phoneController.text);

                        if (whatsAppConfigurationDTO != null) {
                          startPolling(communicationStateManager, branchCode);
                        }

                      }

                    },
                  ),
                ),
              ],
            ),
            if(whatsAppConfigurationDTO != null && whatsAppConfigurationDTO!.pairingCode != '')
              buildRowWithContainers(whatsAppConfigurationDTO!.pairingCode!),
          ],
        );
      },

    );
  }

  void startPolling(CommunicationStateManager communicationStateManager, String branchCode) {
    _pollingTimer?.cancel(); // Cancel any existing timer
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      pollForUpdates(communicationStateManager, branchCode);
    });
  }

  Future<void> pollForUpdates(CommunicationStateManager communicationStateManager, String branchCode) async {
    WhatsAppConfigurationDTO? updatedWhatsAppConfigurationDTO
    = await communicationStateManager.whatsAppConfigurationControllerApi.retrieveWaApiConfStatus(branchCode);

    if(updatedWhatsAppConfigurationDTO != null && updatedWhatsAppConfigurationDTO.waApiState == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA){
        communicationStateManager.setNewWhatsAppConfigurationDTO(updatedWhatsAppConfigurationDTO);
        _pollingTimer?.cancel();
        Fluttertoast.showToast(
          msg: "😎 Numero what'sapp collegato con successo, ora puoi mandare messaggi",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: globalGold,
          timeInSecForIosWeb: 5,
          fontSize: 18.0,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen(pageIndex: 0,)),
        );


    }
  }


  Widget buildRowWithContainers(String input) {
    assert(input.length == 8, 'Input string must be 8 characters long');

    return Column(
      children: [
        Lottie.asset('assets/lotties/whatsapp.json', height: 100),
        Text('+${_prefixController.text} ${_phoneController.text}', style: const TextStyle(fontSize: 30),),
        const Text('Usa questo codice per collegare il tuo numero what\'app a PRO20:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(9, (index) {
            if (index == 4) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  '-',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              int charIndex = index > 4 ? index - 1 : index;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      input[charIndex],
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }
          }),
        ),
        TextButton(onPressed: (){}, child: const Text('Copia Codice📑')),
        LinearProgressIndicator(color: globalGold,)
      ],
    );
  }
}
