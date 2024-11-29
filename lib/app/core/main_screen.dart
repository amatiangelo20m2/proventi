import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:proventi/app/core/whatconf/whatsappconfwidget.dart';
import 'package:proventi/app/login/login_screen.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:badges/badges.dart' as badges;
import 'package:proventi/app/core/booking/booking_fast_queue/fast_queue.dart';
import 'package:proventi/app/core/customer/customer_screen.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import '../../api/communication_client/lib/api.dart';
import '../../landing/landing_page.dart';
import 'booking/booking_confirmed/booking_confirmed.dart';
import 'booking/booking_processed/booking_processed.dart';
import 'booking/booking_to_manage/booking_to_manage.dart';
import 'booking/edited_by_customer/edited_by_customer.dart';
import 'floor/floor.dart';
import 'notification/notification_screen.dart';
import 'notification/state_manager/notification_state_manager.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main_screen';

  const MainScreen({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;


  @override
  void initState() {
    super.initState();
    setPageIndex(widget.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context,
          RestaurantStateManager restaurantStateManager, Widget? child) {
        return Scaffold(

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _pageIndex,
            selectedItemColor: Colors.black,
            backgroundColor: Colors.red,
            useLegacyColorScheme: true,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontSize: 8),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedFontSize: 7,
            onTap: (index) {
              restaurantStateManager.refresh(DateTime.now());
              setPageIndex(index);
            },
            items: [
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/calendar.svg',
                label: BookingDTOStatusEnum.CONFERMATO.value.replaceAll('_', ' '),
                badgeColor: getStatusColor(BookingDTOStatusEnum.CONFERMATO),
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) =>
                        element.status == BookingDTOStatusEnum.CONFERMATO || element.status == BookingDTOStatusEnum.MODIFICA_CONFERMATA)
                    .length,
                isSelected: _pageIndex == 0,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/hourglass.svg',
                label: BookingDTOStatusEnum.IN_ATTESA.value.replaceAll('_', ' '),
                badgeColor: getStatusColor(BookingDTOStatusEnum.IN_ATTESA),
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) =>
                        element.status == BookingDTOStatusEnum.IN_ATTESA)
                    .length,
                isSelected: _pageIndex == 1,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/fast_queue.svg',
                label: BookingDTOStatusEnum.LISTA_ATTESA.value.replaceAll('_', ' '),
                badgeColor: getStatusColor(BookingDTOStatusEnum.LISTA_ATTESA),
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) =>
                        element.status == BookingDTOStatusEnum.LISTA_ATTESA)
                    .length,
                isSelected: _pageIndex == 2,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/booking_edited.svg',
                label: BookingDTOStatusEnum.MODIFICATO_DA_UTENTE.value.replaceAll('_', ' '),
                badgeColor: Colors.deepOrange,
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) =>
                        element.status ==
                        BookingDTOStatusEnum.MODIFICATO_DA_UTENTE || element.status == BookingDTOStatusEnum.ELIMINATO_DA_UTENTE)
                    .length,
                isSelected: _pageIndex == 3,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/check.svg',
                label: 'PROCESSATE',
                badgeColor: Colors.black,
                badgeCount: 0,
                isSelected: _pageIndex == 4,
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.grey[900],
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset('assets/images/logo.png', width: 190),
                const ListTile(
                  title: Text(
                    'Proventi',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  leading: Icon(
                    CupertinoIcons.home,
                    color: CupertinoColors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, CustomerScreen.routeName);
                  },
                  title: const Text(
                    'Lista clienti',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  leading: const Icon(
                    CupertinoIcons.person_2,
                    color: CupertinoColors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, Floor.routeName);
                  },
                  title: const Text(
                    'Floor',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  leading: const Icon(
                    CupertinoIcons.square,
                    color: CupertinoColors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SplashScreen()),
                    );
                  },
                  title: const Text(
                    'Log out',
                    style: TextStyle(color: CupertinoColors.destructiveRed),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
              ],
            ),
          ),

          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.grey[900],
              size: 30,
            ),

            surfaceTintColor: CupertinoColors.white,
            backgroundColor: CupertinoColors.white,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WhatsAppConfWidget(),
                  Consumer<NotificationStateManager>(
                    builder: (BuildContext context,
                        NotificationStateManager value, Widget? child) {
                      return IconButton(
                          onPressed: () async {
                            Navigator.pushNamed(
                                context, NotificationsPage.routeName);
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: badges.Badge(
                                showBadge: value.notifications
                                    .where((element) => element.read == '0')
                                    .isNotEmpty,
                                badgeContent: Text(
                                  value.notifications
                                      .where((element) => element.read == '0')
                                      .length
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                                position: badges.BadgePosition.topEnd(),
                                child: const Icon(CupertinoIcons.bell)),
                          ));
                    },
                  ),
                ],
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/20whitenb.png', width: 50),
                Text(restaurantStateManager.restaurantConfiguration!.restaurantName!,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade900),),
              ],
            ),
          ),
          body: getPageByIndex(_pageIndex,
              restaurantStateManager),
        );
      },
    );
  }

  getPageByIndex(int pageIndex, RestaurantStateManager restaurantStateManager) {

    switch (pageIndex) {
      case 0:
        return const BookingScreen();
      case 1:
        return const BookingManager();
      case 2:
        return const FastQueue();
      case 3:
        return const BookingEditedByCustomer();
      case 4:
        return const ProcessedBookings();
    }
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String svgPath,
    required String label,
    required Color badgeColor,
    required int badgeCount,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: badges.Badge(
        showBadge: badgeCount > 0,
        badgeStyle: badges.BadgeStyle(badgeColor: badgeColor),
        badgeContent: Text(
          badgeCount.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 8),
        ),
        child: SvgPicture.asset(
          color: isSelected ? Colors.black : Colors.grey,
          svgPath,
          height: 23,
        ),
      ),
      label: label,
    );
  }

  void setPageIndex(int index) {
    setState(() {
      _pageIndex = index;
    });
  }
}
