import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:badges/badges.dart' as badges;
import 'package:proventi/app/core/booking/booking_fast_queue/fast_queue.dart';
import 'package:proventi/app/core/customer/customer_screen.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'booking/booking_confirmed/booking.dart';
import 'booking/booking_processed/booking_processed.dart';
import 'booking/booking_to_manage/booking_to_manage.dart';
import 'booking/edited_by_customer/edited_by_customer.dart';
import 'notification/notification_screen.dart';
import 'notification/state_manager/notification_state_manager.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main_screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context,
          RestaurantStateManager restaurantStateManager,
          Widget? child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blueGrey,
            unselectedItemColor: Colors.grey,
           selectedLabelStyle: const TextStyle(fontSize: 8),
           unselectedFontSize: 7,
           onTap: (index){
              setState(() {
                _pageIndex = index;
              });
            },
            items: [
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/calendar.svg',
                label: BookingDTOStatusEnum.CONFERMATO.value,
                badgeColor: getStatusColor(BookingDTOStatusEnum.CONFERMATO),
                badgeCount: restaurantStateManager.allBookings!.where((element) => element.status == BookingDTOStatusEnum.CONFERMATO).length,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/hourglass.svg',
                label: BookingDTOStatusEnum.IN_ATTESA.value,
                badgeColor: getStatusColor(BookingDTOStatusEnum.IN_ATTESA),
                badgeCount: restaurantStateManager.allBookings!
                    .where((element) => element.status == BookingDTOStatusEnum.IN_ATTESA)
                    .length,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/fast_queue.svg',
                label: BookingDTOStatusEnum.LISTA_ATTESA.value,
                badgeColor: getStatusColor(BookingDTOStatusEnum.LISTA_ATTESA),
                badgeCount: restaurantStateManager.allBookings!.where((element) => element.status == BookingDTOStatusEnum.LISTA_ATTESA).length,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/booking_edited.svg',
                label: BookingDTOStatusEnum.MODIFICATO_DA_UTENTE.value,
                badgeColor: Colors.purple,
                badgeCount: restaurantStateManager.allBookings!.where((element) => element.status == BookingDTOStatusEnum.MODIFICATO_DA_UTENTE).length,
              ),
              _buildBottomNavigationBarItem(
                svgPath: 'assets/svg/check.svg',
                label: 'Processate',
                badgeColor: getStatusColor(BookingDTOStatusEnum.ARRIVATO),
                badgeCount: restaurantStateManager.allBookings!.where((element) => element.status == BookingDTOStatusEnum.ARRIVATO || element.status == BookingDTOStatusEnum.RIFIUTATO).length,
              ),
          ],),
          drawer: Drawer(
            child: Column(
              children: [
                const ListTile(
                  title: Text('20m2'),
                  subtitle: Text('xxx'),
                  leading: Icon(CupertinoIcons.home),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, CustomerScreen.routeName);
                  },
                  title: const Text('I tuoi clienti'),
                  subtitle: const Text('xxx'),
                  leading: const Icon(CupertinoIcons.person_2),
                ),
                const ListTile(
                  title: Text('Chat diretta'),
                  subtitle: Text('xxx'),
                  leading: Icon(CupertinoIcons.chat_bubble_2),
                ),
              ],
            ),
          ),
          appBar: AppBar(

            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<NotificationStateManager>(
                    builder: (BuildContext context, NotificationStateManager value, Widget? child) {
                      return IconButton(onPressed: () {
                        Navigator.pushNamed(context, NotificationsPage.routeName);
                      }, icon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: badges.Badge(
                          showBadge: value.notifications.where((element) => element.read == '0').isNotEmpty,
                            badgeContent: Text(value.notifications.where((element) => element.read == '0')
                                .length.toString(), style: const TextStyle(color: Colors.white, fontSize: 11),),
                            position: badges.BadgePosition.topEnd(),
                            child: const Icon(CupertinoIcons.bell)),
                      )
                      );
                    },
                  ),
                ],
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset( 'assets/images/20whitenb.png', fit: BoxFit.contain, height: 50,),
                FloatingActionButton(
                  mini: true,
                  heroTag: "btn1",
                  onPressed: () {

                  },
                  backgroundColor: Colors.green,
                  child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 30,),
                ),

              ],
            ),
          ),
          body: getPageByIndex(_pageIndex),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  getPageByIndex(int pageIndex) {

    switch(pageIndex){
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
          color: Colors.blueGrey,
          svgPath,
          height: 23,
        ),
      ),
      label: label,
    );
  }
}
