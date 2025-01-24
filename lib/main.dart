import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:proventi/state_manager/user_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'app/core/customer/customer_state_manager.dart';
import 'app/core/employee/reports/state_manager/employee_state_manager.dart';
import 'app/core/floor/state_manager/floor_state_manager.dart';
import 'app/core/home_screen.dart';
import 'app/core/notification/model/notification_entity.dart';
import 'app/core/notification/state_manager/notification_state_manager.dart';
import 'landing/landing_page.dart';
import 'routes.dart';
import 'state_manager/restaurant_state_manager.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // Print the message to the console
  print('Handling a background message: ${message.messageId}');
  print('Message Data: ${message.data}');
  if (message.notification != null) {
    print('Notification Title: ${message.notification!.title}');
    print('Notification Body: ${message.notification!.body}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('it', null);
  await _setupFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const Pro20());
}

Future<void> _setupFirebaseMessaging() async {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for notifications
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  // Handle messages when the app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Received a foreground message: ${message.messageId}');
    print('Message data: ${message.toMap().toString()}');

    // Retrieve the current context using a navigator key

      final notification = NotificationModel(title: message.notification!.title!,
          body: message.notification!.body!,
        dateReceived: DateTime.now().toIso8601String(),
        read: '0',
        bookingId: message.data['id_booking'],
        navigationPage: 'XXX');

    try{

      BuildContext context = navigatorKey.currentContext!;

      NotificationStateManager notificationProvider = Provider.of<NotificationStateManager>(context, listen: false);
      RestaurantStateManager restaurantStateManager = Provider.of<RestaurantStateManager>(context, listen: false);
      print('Notification with open app: ${notification.toMap()}');

      await notificationProvider.addNotification(notification);
      await restaurantStateManager.refresh(DateTime.now());
      showDialogPushNotification(context, message);
      print('Show dialog notification');


    }catch(e){
      print('Exception' + e.toString());
    }
  });
}

void showDialogPushNotification(BuildContext context, RemoteMessage message) {

  String bookingId = message.data['id_booking'];
  String navigationPage = message.data['page'];
  int pageIndex = 0;
  DialogType dialogType = DialogType.success;
  switch(navigationPage){
    case 'BOOKING':
      pageIndex = 1;
      dialogType = DialogType.success;
      break;
    case 'BOOKING_UPDATE_BY_CUSTOMER':
      pageIndex = 3;
      dialogType = DialogType.warning;
      break;

  }

  AwesomeDialog(
    dialogBackgroundColor: Colors.white,
    context: context,
    dialogType: dialogType,
    borderSide: const BorderSide(
      color: Colors.white,
      width: 2,
    ),
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    titleTextStyle: TextStyle(color: globalGold),
    descTextStyle: TextStyle(color: Colors.grey[900], fontSize: 13, ),
    btnOk: Padding(
      padding: const EdgeInsets.all(18.0),
      child: CupertinoButton(
        color: blackDir,
        borderRadius: BorderRadius.circular(8),
        onPressed: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen(pageIndex: pageIndex,)),
          );
        }, child: const Text('Gestisci la prenotazione', style: TextStyle(color: CupertinoColors.white),),
      ),
    ),

    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: false,
    headerAnimationLoop: true,
    animType: AnimType.topSlide,
    title: message.notification!.title,
    desc: message.notification!.body!,
    showCloseIcon: false, btnCancelOnPress: null,
    btnOkOnPress: () {},
  ).show();

}

class Pro20 extends StatefulWidget {
  const Pro20({super.key});

  @override
  State<Pro20> createState() => _Pro20State();
}

class _Pro20State extends State<Pro20> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RestaurantStateManager(),),
        ChangeNotifierProvider(create: (context) => NotificationStateManager()),
        ChangeNotifierProvider(create: (context) => EmployeeStateManager()),
        ChangeNotifierProvider(create: (context) => CustomerStateManager()),
        ChangeNotifierProvider(create: (context) => FloorStateManagerProvider()),
        ChangeNotifierProvider(create: (context) => UserStateManager(navigatorKey)),
        ChangeNotifierProvider(create: (context) => CommunicationStateManager(navigatorKey)),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey, // Make sure to add the navigator key here
        supportedLocales: const [
          Locale('en', ''),
          Locale('it', ''),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        routes: Routes.routes,
        title: 'Pro20',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
          fontFamily: 'Arial',

        ),
        home: const SplashScreen(),
      ),
    );
  }

}


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
