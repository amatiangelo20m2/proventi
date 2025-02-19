import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:proventi/app/core/whatconf/all_chat_widget.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../api/communication_client/lib/api.dart';
import '../../landing/landing_page.dart';
import 'booking/booking_confirmed/booking_confirmed.dart';
import 'booking/booking_processed/booking_processed.dart';
import 'booking/booking_to_manage/booking_to_manage.dart';
import 'booking/edited_by_customer/edited_by_customer.dart';
import 'employee/reports/report_employee_presence.dart';
import 'employee/reports/state_manager/employee_state_manager.dart';
import 'floor/floor.dart';
import 'notification/notification_screen.dart';
import 'notification/state_manager/notification_state_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'main_screen';

  const HomeScreen({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: _pageIndex,

            selectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,

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
                sizeIcon: 23,
                svgPath: 'assets/svg/calendar.svg',
                label: BookingDTOStatusEnum.CONFERMATO.value.replaceAll('_', ' '),
                badgeColor: getStatusColor(BookingDTOStatusEnum.CONFERMATO),
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) => isSameDay(element.bookingDate!, DateTime.now()))
                    .where((element) =>
                element.status == BookingDTOStatusEnum.CONFERMATO
                    || element.status == BookingDTOStatusEnum.MODIFICA_CONFERMATA
                    || element.status == BookingDTOStatusEnum.MODIFICA_RIFIUTATA)
                    .length,
                isSelected: _pageIndex == 0,
              ),
              _buildBottomNavigationBarItem(
                sizeIcon: 23,
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
                sizeIcon: 23,
                svgPath: 'assets/svg/fast_queue.svg',
                label: 'PRELAZIONE TAVOLO',
                badgeColor: getStatusColor(BookingDTOStatusEnum.LISTA_ATTESA),
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) =>
                element.status == BookingDTOStatusEnum.LISTA_ATTESA || element.status == BookingDTOStatusEnum.AVVISATO_LISTA_ATTESA)
                    .length,
                isSelected: _pageIndex == 2,
              ),
              _buildBottomNavigationBarItem(
                sizeIcon: 23,
                svgPath: 'assets/svg/booking_edited.svg',
                label: 'MODIFICATO',
                badgeColor: Colors.deepOrange,
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) =>
                element.status ==
                    BookingDTOStatusEnum.MODIFICATO_DA_UTENTE || element.status == BookingDTOStatusEnum.ELIMINATO_DA_UTENTE)
                    .length,
                isSelected: _pageIndex == 3,
              ),
              _buildBottomNavigationBarItem(
                sizeIcon: 23,
                svgPath: 'assets/svg/chat.svg',
                label: 'CHAT',
                badgeColor: Colors.black,
                badgeCount: 0,
                isSelected: _pageIndex == 4,
              ),

            ],
          ),
          drawer: Drawer(
            backgroundColor: blackDir,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset('assets/images/logo.png', width: 190),
                const ListTile(
                  title: Text(
                    'Proventi',
                    style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),
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
          ),

          appBar: AppBar(

            iconTheme: IconThemeData(
              color: blackDir,
              size: 27,
            ),

            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const WhatsAppButtonStatus(),
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
                if(restaurantStateManager.restaurantConfigurations!.isNotEmpty && restaurantStateManager.restaurantConfigurations!.length > 1)IconButton(icon: const Icon(Icons.arrow_drop_down_circle_outlined), onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: Text('Seleziona il branch', style: TextStyle(color: blackDir),),
                      actions: <CupertinoActionSheetAction>[
                        for (var restaurant in restaurantStateManager.restaurantConfigurations!)
                          CupertinoActionSheetAction(
                            child: Builder(
                              builder: (context) {
                                bool isCurrentRestaurant = restaurantStateManager.restaurantConfiguration!.branchCode == restaurant.branchCode;

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(restaurant.restaurantName!, style: TextStyle(color: blackDir, fontSize: isCurrentRestaurant ? 18 : 15),),
                                    Text(isCurrentRestaurant ? '  ✅' : '' , style: TextStyle(color: blackDir),),
                                  ],
                                );
                              }
                            ),
                            onPressed: () async {
                              await restaurantStateManager.retrieveBranchConfiguration(restaurant.branchCode!, DateTime.now());
                              Navigator.of(context).pop();
                            },
                          ),
                      ],
                    ),
                  );
                },),
                Text(
                  restaurantStateManager.restaurantConfiguration != null
                      ? restaurantStateManager.restaurantConfiguration!.restaurantName!
                      : '...',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              getPageByIndex(_pageIndex, restaurantStateManager),
            ],
          ),
        );
      },
    );
  }

  getPageByIndex(int pageIndex, RestaurantStateManager restaurantStateManager) {
    switch (pageIndex) {
      case 0:
        return BookingScreen(dateTime: DateTime.now(),);
      case 1:
        return const BookingManager();
      case 2:
        return const FastQueue();
      case 3:
        return const BookingEditedByCustomer();
      case 4:
        return const AllChatWidget();
    }
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String svgPath,
    required String label,
    required Color badgeColor,
    required int badgeCount,
    required bool isSelected,
    required double sizeIcon,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
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
          height: sizeIcon,
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
