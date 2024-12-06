import 'package:flutter/cupertino.dart';

import 'app/core/customer/customer_screen.dart';
import 'app/core/employee/reports/employee_create_update/employee_screen.dart';
import 'app/core/employee/reports/report_employee_presence.dart';
import 'app/core/floor/floor.dart';
import 'app/core/notification/notification_screen.dart';
import 'app/core/whatconf/link_whatsapp_component.dart';

class Routes {
  static Map<String, StatefulWidget Function(dynamic context)> routes = {
    NotificationsPage.routeName: (context) => NotificationsPage(),
    CustomerScreen.routeName: (context) => const CustomerScreen(),
    Floor.routeName: (context) => const Floor(),
    LinkWhatsAppComponent.routeName: (context) => const LinkWhatsAppComponent(),
    EmployeeScreen.routeName: (context) => const EmployeeScreen(),
    ReportEmployeePresence.routeName: (context) => const ReportEmployeePresence(),
  };
}