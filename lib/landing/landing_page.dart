import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proventi/environment_config.dart';
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import '../app/login/login_screen.dart';
import '../state_manager/user_state_manager.dart';
import 'update_app_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  final _updater = ShorebirdUpdater();
  late final bool _isUpdaterAvailable;
  var _isCheckingForUpdates = false;
  Patch? _currentPatch;

  @override
  void initState() {
    super.initState();

    setState(() => _isUpdaterAvailable = _updater.isAvailable);
    print(_updater.readCurrentPatch());



    _updater.readCurrentPatch().then((currentPatch) {
      setState(() => _currentPatch = currentPatch);
    }).catchError((Object error) {
      debugPrint('Error reading current patch: $error');
    });
    _checkForUpdate();

  }


  Future<void> _checkForUpdate() async {
    if (_isCheckingForUpdates) return;

    try {
      setState(() => _isCheckingForUpdates = true);
      // Check if there's an update available.
      final status = await _updater.checkForUpdate(track: UpdateTrack.stable);
      if (!mounted) return;
      // If there is an update available, show a banner.
      switch (status) {
        case UpdateStatus.upToDate:
        // Do nothing, the app is up to date.
          break;
        case UpdateStatus.outdated:
          _showUpdateAvailableBanner();
        case UpdateStatus.restartRequired:
          _showRestartBanner();
        case UpdateStatus.unavailable:
        // Do nothing, there is already a warning displayed at the top of the
        // screen.
      }
    } catch (error) {
      // If an error occurs, we log it for now.
      debugPrint('Error checking for update: $error');
    } finally {
      setState(() => _isCheckingForUpdates = false);
    }
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _downloadUpdate() async {
    _showDownloadingBanner();
    try {
      await _updater.update(track: UpdateTrack.stable);
      if (!mounted) return;
      _showRestartBanner();
    } on UpdateException catch (error) {
      _showErrorBanner(error.message);
    }
  }

  void _showDownloadingBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        const MaterialBanner(
          content: Text('Downloading...'),
          actions: [
            SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
  }
  void _showRestartBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: const Text('A new patch is ready! Please restart your app.'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
  }
  void _showErrorBanner(Object error) {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text(
            'An error occurred while downloading the update: $error.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
  }
  void _showUpdateAvailableBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: const Text(
            'Scarica aggiornamento',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                await _downloadUpdate();
                if (!mounted) return;
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Download'),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthenticatorAndUserStateManager>(
      builder: (BuildContext context, AuthenticatorAndUserStateManager authStateManager, Widget? child) {
        return FutureBuilder<String>(
          future: authStateManager.retrieveAppVersion(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: blackDir,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 0,),
                      Hero(
                        tag: 'logo_landing',
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: CupertinoActivityIndicator(
                                radius: 15,
                                color: globalGold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                backgroundColor: blackDir,
                body: Center(
                  child: Text(
                    'Errore: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else {

              if(snapshot.data == version_app){
                _loadData();
                return Scaffold(
                  backgroundColor: blackDir,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 0,),
                        Hero(
                          tag: 'logo_landing',
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Versione app: ${snapshot.data}',
                                style: TextStyle(color: Colors.white, fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: CupertinoActivityIndicator(
                                  radius: 15,
                                  color: globalGold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                return UpdateAppWidget(appVersion: snapshot.data.toString(),);
              }
            }
          },
        );
      },
    );
  }
}
