import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../../../../global/style.dart';
import '../../../../../state_manager/restaurant_state_manager.dart';
import '../../../../custom_widgets/toggle_pro20/appinio_animated_toggle_tab.dart';
import '../confirmedcard_extra/filter_daily_type.dart';


class RangeTimeSelector extends StatefulWidget {
  final Function(FilterDailyType) onFilterDailyTypeChanged;

  final DateTime selectedDate;
  const RangeTimeSelector({super.key, required this.onFilterDailyTypeChanged, required this.selectedDate});

  @override
  State<RangeTimeSelector> createState() => _RangeTimeSelectorState();
}

class _RangeTimeSelectorState extends State<RangeTimeSelector> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context, RestaurantStateManager restaurantStateManager, Widget? child) {
        return SwitchPro20(
          callback: (int i) {
            FilterDailyType newType;
            String toastMessage;
            Color toastColor;

            switch (i) {
              case 0:
                newType = FilterDailyType.TUTTO_IL_GIORNO;
                toastMessage = "Prenotazioni di tutta la giornata";
                toastColor = globalGoldDark;
                break;
              case 1:
                newType = FilterDailyType.PRANZO;
                toastMessage = "Prenotazioni pranzo";
                toastColor = globalGold;
                break;
              case 2:
                newType = FilterDailyType.CENA;
                toastMessage = "Prenotazioni cena";
                toastColor = elegantBlue;
                break;
              default:
                return;
            }

            widget.onFilterDailyTypeChanged(newType);
            Fluttertoast.showToast(
              msg: toastMessage,
              backgroundColor: toastColor,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          },
          tabTexts: [
            badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.grey.shade800),
              badgeContent: Text(
                restaurantStateManager.retrieveTotalTableNumberForDayAndActiveBookings(widget.selectedDate).toString(),
                style: const TextStyle(fontSize: 10, color: CupertinoColors.white),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(CupertinoIcons.infinite, size: 25),
              ),
            ),
            badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: globalGoldDark),
              badgeContent: Text(
                restaurantStateManager.retrieveTotalTablesNumberForDayAndActiveBookingsLunchTime(widget.selectedDate, restaurantStateManager.restaurantConfiguration!).toString(),
                style: const TextStyle(fontSize: 10, color: CupertinoColors.white),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(CupertinoIcons.sun_max, size: 25, color: globalGoldDark),
              ),
            ),
            badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: elegantBlue),
              badgeContent: Text(
                restaurantStateManager.retrieveTotalTablesNumberForDayAndActiveBookingsDinnerTime(widget.selectedDate, restaurantStateManager.restaurantConfiguration!).toString(),
                style: const TextStyle(fontSize: 10, color: CupertinoColors.white),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(CupertinoIcons.moon_stars, color: elegantBlue, size: 25),
              ),
            ),
          ],
          height: 40,
          width: 130,
          boxDecoration: const BoxDecoration(color: Colors.transparent),
          animatedBoxDecoration: BoxDecoration(
            color: Colors.grey.withAlpha(40),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: blackDir, width: 2),
          ),
          activeStyle: const TextStyle(color: Colors.white),
          inactiveStyle: const TextStyle(color: Colors.black),
        );
      },
    );
  }
}