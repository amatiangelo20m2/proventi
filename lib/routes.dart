import 'package:flutter/cupertino.dart';

import 'app/core/customer/customer_screen.dart';
import 'app/core/notification/notification_screen.dart';
import 'app/core/whatsapp/chat_whatsapp.dart';

class Routes {
  static Map<String, StatefulWidget Function(dynamic context)> routes = {
    NotificationsPage.routeName: (context) => NotificationsPage(),
    CustomerScreen.routeName: (context) => const CustomerScreen(),
    ChatWhatsApp.routeName: (context) => const ChatWhatsApp(),
  };
}