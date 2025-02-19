import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api/client/lib/api.dart';
import '../api/auth_client/lib/api.dart' as AUTH;
import '../environment_config.dart';
import '../global/style.dart';

class AuthenticatorAndUserStateManager extends ChangeNotifier {

  final GlobalKey<NavigatorState> navigatorKey;

  late AUTH.ApiClient _apiAuthClient;
  late AUTH.AuthControllerApi _authenticationControllerApi;

  late ApiClient _apiClient;
  late BranchControllerApi _branchControllerApi;

  late VentiMetriQuadriData _ventiMetriQuadriData;

  ApiClient get apiClient => _apiClient;
  VentiMetriQuadriData get ventiMetriQuadriData => _ventiMetriQuadriData;

  AuthenticatorAndUserStateManager(this.navigatorKey){
    _initializeClient();
  }


  Future<String> retrieveAppVersion() async {
    final response = await _authenticationControllerApi.getAppVersionWithHttpInfo();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Errore durante il recupero della versione dell\'app. Contattare assistenza');
    }
  }

  void _initializeClient() {
    print('Initialize client auth with $customBasePathAuth. Each call will be redirect to this url.');

    _apiAuthClient = AUTH.ApiClient(basePath: customBasePathAuth);
    _authenticationControllerApi = AUTH.AuthControllerApi(_apiAuthClient);

    print('Initialize client with $customBasePath. Each call will be redirect to this url.');

    _apiClient = ApiClient(basePath: customBasePath);
    _branchControllerApi = BranchControllerApi(_apiClient);
  }

  Future<void> loginWithUserCodeAndPass(String userCode,
      String password,
      String fcmToken, BuildContext context) async {

    try {
      final httpResult = await _authenticationControllerApi.signInWithUserCodeWithHttpInfo(
        AUTH.UserCodeCredential(userCode: userCode, password: password),
      );

      print('Status code: ' + httpResult.statusCode.toString());
      print(httpResult);

      if (httpResult.statusCode == 200) {
        final branchResponse = await _branchControllerApi.retrieveBranches(userCode, BranchResponseEntityTypeEnum.RISTORANTE.value, fcmToken: fcmToken);

        if (branchResponse != null) {
          _ventiMetriQuadriData = branchResponse;
          notifyListeners();
        } else {
          showCupertinoAlert(context, 'Errore', 'Attività non trovata, riprova oppure controlla credenziali');
        }
      }else if(httpResult.statusCode == 401){
        showCupertinoAlert(context, 'Errore', 'Credenziali non valide');
      } else {
        showCupertinoAlert(context, 'Errore', 'Errore non riconosciuto, riprova');
      }
    } catch (error) {
      showCupertinoAlert(context, 'Errore', error.toString());
    }
  }

  void showCupertinoAlert(BuildContext context, String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}