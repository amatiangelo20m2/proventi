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
import 'package:uuid/uuid.dart';
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
  bool _showLoadingPage = false;

  @override
  void initState() {
    super.initState();
    _fetchDeviceInfo();
    _retrieveFcmToken();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _rememberCredentials = prefs.getBool('rememberCredentials') ?? false;
      String? loginMethod = prefs.getString('loginMethod');

      if (_rememberCredentials) {
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
        _branchCodeController.text = prefs.getString('branchCode') ?? '';
        _userCodeController.text = prefs.getString('userCode') ?? '';
        _passwordUserController.text = prefs.getString('userPassword') ?? '';
        _isLoginWithUserCode = prefs.getBool('loginWithUserCode') ?? false;

        if (loginMethod == 'with_user_code') {
          setState(() {
            _showLoadingPage = true;
          });
          print('Auto login with user code');
          _loginWithUserCode();
        } else if (loginMethod == 'with_branch_code') {
          setState(() {
            _showLoadingPage = true;
          });
          print('Auto login with branch code');
          _loginWithBranchCode();
        }
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
      await prefs.setString('loginMethod', _isLoginWithUserCode ? 'with_user_code' : 'with_branch_code');
      await prefs.setBool('loginWithUserCode', _isLoginWithUserCode);
    } else {
      await prefs.remove('rememberCredentials');
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.remove('branchCode');
      await prefs.remove('userCode');
      await prefs.remove('userPassword');
      await prefs.remove('loginMethod');
      await prefs.remove('loginWithUserCode');
    }
  }

  Future<void> _retrieveFcmToken() async {
    const int maxRetries = 5;
    const Duration retryDelay = Duration(seconds: 2);
    int retryCount = 0;

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token;
        while (token == null && retryCount < maxRetries) {
          token = await messaging.getToken();
          if (token != null && token.isNotEmpty) {
            setState(() => mdd.fcmToken = token);
            print('FCM Token: ${mdd.fcmToken}');
          } else {
            retryCount++;
            await Future.delayed(retryDelay);
          }
        }

        if (token == null) {
          _showRestartAppDialog();
        }

        // Listen for token refresh
        FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
          setState(() => mdd.fcmToken = newToken);
          print('FCM Token refreshed: ${mdd.fcmToken}');
        });
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
    final prefs = await SharedPreferences.getInstance();

    String? uniqueId = prefs.getString('uniqueId');
    if (uniqueId == null) {
      uniqueId = const Uuid().v4();
      await prefs.setString('uniqueId', uniqueId);
    }

    mdd.uniquePhoneIdentifier = uniqueId;
    print('Unique Identifier: $uniqueId');

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
      //mdd.uniquePhoneIdentifier = iosInfo.identifierForVendor;
      //print('identifier: ' + mdd.uniquePhoneIdentifier.toString());
      mdd.systemVersion = iosInfo.utsname.nodename;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<RestaurantStateManager>(
        builder: (BuildContext context, RestaurantStateManager value, Widget? child) {
          return Scaffold(
            backgroundColor: blackDir,
            body: _showLoadingPage ? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  color: globalGold,
                ),
                const Column(
                  children: [
                    Text('Carico i dati...', style: TextStyle(color: CupertinoColors.white, fontSize: 12)),
                  ],
                ),
              ],
            )) : Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Text('fcm. ${mdd.fcmToken}', style: TextStyle(color: CupertinoColors.white, fontSize: 2)),

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
      style: TextStyle(fontFamily: globalFontFamily),
      placeholder: placeholder,
      obscureText: isPassword ? !_passwordVisible : isUserPassword ? !_passwordUserVisible : obscureText,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],

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
        Text('Ricorda credenziali', style: TextStyle(color: CupertinoColors.white, fontSize: 10)),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: globalGold,
        onPressed: _isLoading ? null : _login,
        child: Text('ACCEDI',
            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: globalFontFamily)),
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
        await _loginWithBranchCode();
      } else {
        await _loginWithUserCode();
      }
    } catch (e) {
      showCupertinoAlert(context, 'Error', 'An error occurred: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithBranchCode() async {
    await Future.delayed(const Duration(milliseconds: 500));

    print("BranchCode: ${_branchCodeController.text}");
    print("Username: ${_usernameController.text}");
    print("Password: ${_passwordController.text}");

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
      setState(() {
        _showLoadingPage = false;
      });
    } else if (response.statusCode == 401) {
      showCupertinoAlert(context, 'Errore', 'Password errata');
      setState(() {
        _showLoadingPage = false;
      });
    } else {
      showCupertinoAlert(context, 'Errore', 'Errore generico');
      setState(() {
        _showLoadingPage = false;
      });
    }
  }

  Future<void> _loginWithUserCode() async {
    try{
      print("UserCode: ${_userCodeController.text}");
      print("Password: ${_passwordUserController.text}");

      await _retrieveFcmToken();
      await Provider.of<RestaurantStateManager>(context, listen: false).setBranchList([]);

      print('FCM Token: ${mdd.fcmToken}');

      await Provider.of<AuthenticatorAndUserStateManager>(context, listen: false).loginWithUserCodeAndPass(
        _userCodeController.text,
        _passwordUserController.text,
        mdd.fcmToken!,
        context,
      );

      VentiMetriQuadriData ventiMetriQuadriData = await Provider.of<AuthenticatorAndUserStateManager>(context, listen: false).ventiMetriQuadriData;

      List<RestaurantDTO> restaurantDTOs = [];
      for (BranchResponseEntity branchResEntity in ventiMetriQuadriData.branches) {
        restaurantDTOs.add(RestaurantDTO(
          branchCode: branchResEntity.branchCode,
          restaurantName: branchResEntity.name,
        ));
      }

      await Provider.of<RestaurantStateManager>(context, listen: false).setBranchList(restaurantDTOs);
      await _saveCredentials();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen(pageIndex: 0)));

    }catch(e){
      print('Exception$e');
      setState(() {
        _showLoadingPage = false;
      });
    }
  }

  Future<String> _decodeBodyBytes(Response response) async {
    final contentType = response.headers['content-type'];
    return contentType != null && contentType.toLowerCase().startsWith('application/json')
        ? response.bodyBytes.isEmpty ? '' : utf8.decode(response.bodyBytes)
        : response.body;
  }
}