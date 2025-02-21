import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/style.dart';
import '../../../landing/landing_page.dart';
import '../booking/booking_processed/booking_processed.dart';
import '../customer/customer_screen.dart';
import '../employee/reports/report_employee_presence.dart';
import '../employee/reports/state_manager/employee_state_manager.dart';

class ProventiDrawer extends StatefulWidget {
  const ProventiDrawer({super.key});

  @override
  State<ProventiDrawer> createState() => _ProventiDrawerState();
}

class _ProventiDrawerState extends State<ProventiDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: blackDir,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset('assets/images/logo.png', width: 120),

          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, CustomerScreen.routeName);
            },
            title: const Text(
              'Lista clienti',
              style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              CupertinoIcons.person_2,
              color: CupertinoColors.white,
            ),
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();
              await EmployeeStateManager().retrieveCurrentEmployee();
              Navigator.pushNamed(context, ProcessedBookings.routeName);
            },
            title: const Text(
              'Storico Prenotazioni',
              style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              CupertinoIcons.square_list,
              color: CupertinoColors.white,
            ),
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, ReportEmployeePresence.routeName);
            },
            title: const Text(
              'Report Dipendenti',
              style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              CupertinoIcons.calendar_badge_plus,
              color: CupertinoColors.white,
            ),
          ),

          ListTile(
            onTap: () async {
              Navigator.of(context).pop();
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('loginMethod');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SplashScreen()),
              );
            },
            title: const Text(
              'Log out',
              style: TextStyle(color: CupertinoColors.destructiveRed, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.logout,
              color: CupertinoColors.destructiveRed,
            ),
          ),
        ],
      ),
    );
  }
}
