import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/src/response.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global/style.dart';
import '../../state_manager/restaurant_state_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  final TextEditingController _branchCodeController = TextEditingController(text: '');

  MobileDeviceDetails mdd = MobileDeviceDetails();
  bool _isLoading = false;

  bool _rememberCredentials = false;

  @override
  void initState() {
    super.initState();
    _fetchDeviceInfo();
    _retrieveFcmToken();
    _loadSavedCredentials();
    _checkIfUserAlreadyLoggedIn();
  }


  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _rememberCredentials = prefs.getBool('rememberCredentials') ?? false;

      if (_rememberCredentials) {
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
        _branchCodeController.text = prefs.getString('branchCode') ?? '';
      }
    });
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    if (_rememberCredentials) {
      await prefs.setBool('rememberCredentials', true);
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setString('branchCode', _branchCodeController.text);
    } else {
      await prefs.remove('rememberCredentials');
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.remove('branchCode');
    }
  }

  Future<void> _checkIfUserAlreadyLoggedIn() async {
    var employeeDTO = Provider.of<RestaurantStateManager>(context, listen: false).currentEmployee;
    if(employeeDTO != null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen(pageIndex: 0,)),
      );
    }
  }

  Future<void> _retrieveFcmToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await messaging.getToken();
        setState(() => mdd.fcmToken = token);
        print('FCM Token: ${mdd.fcmToken}');
      }
    } catch (e) {
      print("Error retrieving FCM token: $e");
    }
  }

  Future<void> _fetchDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      mdd.model = androidInfo.model;
      mdd.platform = Platform.operatingSystem;
      mdd.systemVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      mdd.model = iosInfo.model;
      mdd.platform = Platform.operatingSystem;
      mdd.machine = iosInfo.utsname.machine;
      mdd.release = iosInfo.utsname.release;
      mdd.uniquePhoneIdentifier = iosInfo.identifierForVendor;
      print('identifier: ' + mdd.uniquePhoneIdentifier.toString());
      mdd.systemVersion = iosInfo.utsname.nodename;
      print('nodename: ' + mdd.systemVersion.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
      },
      child: Consumer<RestaurantStateManager>(
        builder:
            (BuildContext context, RestaurantStateManager value, Widget? child) {
          return Scaffold(
            backgroundColor: blackDir,
            body: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logo.png', width: 190),
                          const SizedBox(height: 16),
                          CupertinoTextField(
                            clearButtonMode: OverlayVisibilityMode.always,
                            controller: _branchCodeController,
                            keyboardType: TextInputType.text,
                            placeholder: 'Codice Attività',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            padding: const EdgeInsets.all(10),
                            onChanged: (text) {
                              _branchCodeController.value = _branchCodeController.value.copyWith(
                                text: text.toUpperCase(),
                                selection: TextSelection.collapsed(offset: text.length),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          CupertinoTextField(
                            controller: _usernameController,
                            placeholder: 'Username',
                            padding: const EdgeInsets.all(10),
                          ),
                          const SizedBox(height: 16),
                          CupertinoTextField(
                            controller: _passwordController,
                            placeholder: 'Password',
                            obscureText: true,
                            padding: const EdgeInsets.all(10),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoCheckbox(
                                  activeColor: globalGold,
                                  value: _rememberCredentials,
                                  onChanged: (re){
                                    setState(() {
                                      _rememberCredentials = !_rememberCredentials;
                                    });
                                  }),
                              Text('Ricorda credenziali', style: TextStyle(color: CupertinoColors.white, fontSize: 15),),

                            ],
                          ),
                          const SizedBox(height: 15),
                          CupertinoButton(
                            color: globalGold,
                            onPressed: _isLoading ? null : _login,
                            child: const Text('Accedi', style: TextStyle(color: Colors.white),),
                          ),
                          const SizedBox(height: 32),

                        ],
                      ),
                    ),
                  ),
                ),
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        radius: 20.0,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _login() async {
    if (_branchCodeController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      showCupertinoAlert(context, 'Errore', 'I campi del form sono obbligatori');
      return; // Exit the function if validation fails
    }

    setState(() => _isLoading = true); // Show loading indicator

    try {
      print("Username: ${_usernameController.text}");
      print("Password: ${_passwordController.text}");
      print("Branch Code: ${_branchCodeController.text}");


      mdd.registrationDate = DateTime.now();
      var response = await Provider.of<RestaurantStateManager>(context, listen: false)
          .restaurantControllerApi
          .loginFromMobileDeviceWithHttpInfo(
          _branchCodeController.text,
          _usernameController.text,
          _passwordController.text,
          mdd);

      if (response.statusCode == 202) {
        if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {

          EmployeeDTO employeeDTO = await Provider.of<RestaurantStateManager>(context, listen: false)
              .restaurantClient
              .deserializeAsync(await _decodeBodyBytes(response), 'EmployeeDTO') as EmployeeDTO;

          await Provider.of<RestaurantStateManager>(context, listen: false)
              .setDataEmployeeAndRetrieveData(employeeDTO, DateTime.now());

          await _saveCredentials(); // Save credentials if the login is successful

          
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen(pageIndex: 0,)),
          );
        }else{
          showCupertinoAlert(context, 'Error', 'Non sono riuscito a decodificare oggetto in entrata. Contatta supporto');
        }
      } else if (response.statusCode == 204) {
        showCupertinoAlert(context, 'Error', 'User not found');
      } else if (response.statusCode == 401) {
        showCupertinoAlert(context, 'Error', 'Incorrect password');
      } else {
        showCupertinoAlert(context, 'Error', 'Errore generico');
      }
    } catch (e) {
      showCupertinoAlert(context, 'Error', 'An error occurred: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<String> _decodeBodyBytes(Response response) async {
    final contentType = response.headers['content-type'];
    return contentType != null && contentType.toLowerCase().startsWith('application/json')
        ? response.bodyBytes.isEmpty ? '' : utf8.decode(response.bodyBytes)
        : response.body;
  }

}
