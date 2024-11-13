import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/core/customer/customer_state_manager.dart';
import 'app/core/employee/reports/state_manager/employee_state_manager.dart';
import 'app/core/notification/model/notification_entity.dart';
import 'app/core/notification/state_manager/notification_state_manager.dart';
import 'landing/landing_page.dart';
import 'routes.dart';
import 'state_manager/restaurant_state_manager.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages if needed
  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('it', null);
  await _setupFirebaseMessaging();

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

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle messages when the app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Received a foreground message: ${message.messageId}');
    print('Message data: ${message.toMap().toString()}');

    // Retrieve the current context using a navigator key

      final notification = NotificationModel(title: message.notification!.title!,
          body: message.notification!.body!,
        dateReceived: DateTime.now().toUtc().toIso8601String(),
        read: '0',
        navigationPage: 'XXX', );

    try{
      print('12');
      BuildContext context = navigatorKey.currentContext!;
      NotificationStateManager notificationProvider = Provider.of<NotificationStateManager>(context, listen: false);
      print('Notification with open app: ${notification.toMap()}');
      await notificationProvider.addNotification(notification);
    }catch(e){
      print('Exception' + e.toString());
    }
  });
}


class Pro20 extends StatelessWidget {
  const Pro20({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RestaurantStateManager(),),
        ChangeNotifierProvider(create: (context) => NotificationStateManager()),
        ChangeNotifierProvider(create: (context) => EmployeeStateManager()),
        ChangeNotifierProvider(create: (context) => CustomerStateManager()),
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'Helvetica',

        ),
        home: const SplashScreen(),
      ),
    );
  }
}

// Define a global navigator key for context retrieval
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
