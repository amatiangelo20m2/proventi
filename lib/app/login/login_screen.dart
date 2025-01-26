import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/src/response.dart';
import 'package:proventi/api/client/lib/api.dart';
import 'package:proventi/state_manager/user_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../environment_config.dart';
import '../../global/style.dart';
import '../../state_manager/restaurant_state_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _branchCodeController = TextEditingController(text: '');
  final TextEditingController _usernameController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  final TextEditingController _userCodeController = TextEditingController(text: '');
  final TextEditingController _passwordUserController = TextEditingController(text: '');

  MobileDeviceDetails mdd = MobileDeviceDetails();
  bool _isLoading = false;
  bool _isLoginWithUserCode = false;
  bool _rememberCredentials = false;
  bool _passwordVisible = false;
  bool _passwordUserVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchDeviceInfo();
    _retrieveFcmToken();
    _loadSavedCredentials();
    //_checkIfUserAlreadyLoggedIn();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _rememberCredentials = prefs.getBool('rememberCredentials') ?? false;

      if (_rememberCredentials) {
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
        _branchCodeController.text = prefs.getString('branchCode') ?? '';
        _userCodeController.text = prefs.getString('userCode') ?? '';
        _passwordUserController.text = prefs.getString('userPassword') ?? '';
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
      await prefs.setString('userCode', _userCodeController.text);
      await prefs.setString('userPassword', _passwordUserController.text);
    } else {
      await prefs.remove('rememberCredentials');
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.remove('branchCode');
      await prefs.remove('userCode');
      await prefs.remove('userPassword');
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
        if (token != null) {
          setState(() => mdd.fcmToken = token);
          print('FCM Token: ${mdd.fcmToken}');
        } else {
          _showRestartAppDialog();
        }
      } else {
        _showRestartAppDialog();
      }
    } catch (e) {
      print("Error retrieving FCM token: $e");
      _showRestartAppDialog();
    }
  }

  void _showRestartAppDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Errore'),
          content: const Text('Si è verificato un errore durante il recupero del token FCM. Si prega di riavviare l\'applicazione.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        builder: (BuildContext context, RestaurantStateManager value, Widget? child) {
          return Scaffold(
            backgroundColor: blackDir,
            body: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_isLoginWithUserCode ? 'Accedi con codice utente' : 'Accedi con codice attività', style: const TextStyle(color: CupertinoColors.white, fontSize: 10)),
                                Switch(
                                  activeColor: globalGold,
                                  inactiveThumbColor: globalGold,
                                  value: _isLoginWithUserCode,
                                  onChanged: (value) {
                                    setState(() {
                                      _isLoginWithUserCode = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Card(
                                shadowColor: Colors.black,
                                surfaceTintColor: blackDir,
                                color: blackDir,
                                elevation: 23,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Hero(tag: 'logo_landing', child: Image.asset('assets/images/logo.png', width: 120)),

                                    _isLoginWithUserCode ? _buildUserCodeLogin() : _buildBranchCodeLogin(),
                                  ],
                                ),
                              ),
                              Text('v. $version_app', style: TextStyle(color: CupertinoColors.white, fontSize: 8)),
                            ],
                          ),
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

  Widget _buildBranchCodeLogin() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 16, bottom: 20),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildTextField(_branchCodeController, 'Codice Attività', TextInputType.text, toUpperCase: true),
          const SizedBox(height: 16),
          _buildTextField(_usernameController, 'Username', TextInputType.text),
          const SizedBox(height: 16),
          _buildTextField(_passwordController, 'Password', TextInputType.visiblePassword, obscureText: true, isPassword: true),
          const SizedBox(height: 32),
          _buildRememberCredentials(),
          const SizedBox(height: 15),
          _buildLoginButton(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildUserCodeLogin() {
    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildTextField(_userCodeController, 'Codice Utente', TextInputType.text, toUpperCase: true),
          const SizedBox(height: 16),
          _buildTextField(_passwordUserController, 'Password', TextInputType.visiblePassword, obscureText: true, isPassword: true, isUserPassword: true),
          const SizedBox(height: 16),
          _buildRememberCredentials(),
          const SizedBox(height: 15),
          _buildLoginButton(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String placeholder, TextInputType keyboardType, {bool obscureText = false, bool toUpperCase = false, bool isPassword = false, bool isUserPassword = false}) {
    return CupertinoTextField(
      clearButtonMode: OverlayVisibilityMode.always,
      controller: controller,
      keyboardType: keyboardType,
      placeholder: placeholder,
      obscureText: isPassword ? !_passwordVisible : isUserPassword ? !_passwordUserVisible : obscureText,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.all(10),
      suffix: isPassword || isUserPassword
          ? Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
                    child: Icon(
            isPassword ? (_passwordVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye) : (_passwordUserVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
            color: Colors.grey,
                    ),
                    onTap: () {
            setState(() {
              if (isPassword) {
                _passwordVisible = !_passwordVisible;
              } else if (isUserPassword) {
                _passwordUserVisible = !_passwordUserVisible;
              }
            });
                    },
                  ),
          )
          : null,
      onChanged: (text) {
        controller.value = controller.value.copyWith(
          text: toUpperCase ? text.toUpperCase() : text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      },
    );
  }

  Widget _buildRememberCredentials() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoCheckbox(
          activeColor: globalGold,
          value: _rememberCredentials,
          onChanged: (re) {
            setState(() {
              _rememberCredentials = !_rememberCredentials;
            });
          },
        ),
        const Text('Ricorda credenziali', style: TextStyle(color: CupertinoColors.white, fontSize: 10)),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: globalGold,
        onPressed: _isLoading ? null : _login,
        child: const Text('ACCEDI', style: TextStyle(color: Colors.white, fontSize: 13)),
      ),
    );
  }

  Future<void> _login() async {
    if (!_isLoginWithUserCode && (_branchCodeController.text.isEmpty || _usernameController.text.isEmpty || _passwordController.text.isEmpty)) {
      showCupertinoAlert(context, 'Errore', 'I campi del form sono obbligatori');
      return; // Exit the function if validation fails
    } else if (_isLoginWithUserCode && (_userCodeController.text.isEmpty || _passwordUserController.text.isEmpty)) {
      showCupertinoAlert(context, 'Errore', 'I campi del form sono obbligatori');
    }

    setState(() => _isLoading = true); // Show loading indicator

    try {
      mdd.registrationDate = DateTime.now();

      if (!_isLoginWithUserCode) {
        var response = await Provider.of<RestaurantStateManager>(context, listen: false)
            .restaurantControllerApi
            .loginFromMobileDeviceWithHttpInfo(
          _branchCodeController.text,
          _usernameController.text,
          _passwordController.text,
          mdd,
        );

        if (response.statusCode == 202) {
          if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
            EmployeeDTO employeeDTO = await Provider.of<RestaurantStateManager>(context, listen: false)
                .restaurantClient.deserializeAsync(await _decodeBodyBytes(response), 'EmployeeDTO') as EmployeeDTO;
            print('Log in with employeeDTO: $employeeDTO');

            RestaurantDTO? restaurantDTO = await Provider.of<RestaurantStateManager>(context, listen: false)
                .restaurantControllerApi.retrieveConfiguration(employeeDTO.branchCode!, 'XXX');

            await Provider.of<RestaurantStateManager>(context, listen: false).setBranchList([restaurantDTO!]);
            await _saveCredentials();

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen(pageIndex: 0)));
          } else {
            showCupertinoAlert(context, 'Error', 'Non sono riuscito a decodificare oggetto in entrata. Contatta supporto');
          }
        } else if (response.statusCode == 204) {
          showCupertinoAlert(context, 'Errore', 'Utente non trovato');
        } else if (response.statusCode == 401) {
          showCupertinoAlert(context, 'Errore', 'Password errata');
        } else {
          showCupertinoAlert(context, 'Errore', 'Errore generico');
        }
      } else {
        print("UserCode: ${_userCodeController.text}");
        print("Password: ${_passwordUserController.text}");

        await Provider.of<RestaurantStateManager>(context, listen: false).setBranchList([]);

        print('FCM Token: ${mdd.fcmToken}');

        await Provider.of<UserStateManager>(context, listen: false).loginWithUserCodeAndPass(_userCodeController.text,
            _passwordUserController.text, mdd.fcmToken!);

        print('User logged in with user code');
        VentiMetriQuadriData ventiMetriQuadriData = await Provider.of<UserStateManager>(context, listen: false).ventiMetriQuadriData;

        //here i will convert a BranchResponseEntity list into a Restaurant configuration in order to have a list of branchConfiguration, when the customer will choose a branch it will refresh the configuration each time
        List<RestaurantDTO> restaurantDTOs = [];
        for(BranchResponseEntity branchResEntity in ventiMetriQuadriData.branches){
          restaurantDTOs.add(RestaurantDTO(
            branchCode: branchResEntity.branchCode,
            restaurantName: branchResEntity.name,
          ));
        }

        await Provider.of<RestaurantStateManager>(context, listen: false).setBranchList(restaurantDTOs);
        await _saveCredentials();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen(pageIndex: 0)));

        //await Provider.of<RestaurantStateManager>(context, listen: false).

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