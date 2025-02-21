import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/app/core/booking/booking_confirmed/confirmedcard_extra/filter_daily_type.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';

import '../../../../../global/style.dart';

class CurrentGuestSituation extends StatefulWidget {

  final RestaurantStateManager restaurantManager;
  final DateTime selectedDate;
  final FilterDailyType filterDailyType;

  const CurrentGuestSituation({super.key, required this.restaurantManager, required this.selectedDate, required this.filterDailyType});

  @override
  State<CurrentGuestSituation> createState() => _CurrentGuestSituationState();
}

class _CurrentGuestSituationState extends State<CurrentGuestSituation> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(

      onPressed: () {  },
      label: Padding(
        padding: const EdgeInsets.only(right: 4, left: 4),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // Apply conditional logic to the content inside the Text widget
                widget.filterDailyType == FilterDailyType.TUTTO_IL_GIORNO
                    ? widget.restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookings(widget.selectedDate).toString()
                    : widget.filterDailyType == FilterDailyType.PRANZO
                    ? widget.restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookingsLunchTime(
                    widget.selectedDate, widget.restaurantManager.restaurantConfiguration!).toString()
                    : widget.restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookingsDinnerTime(
                    widget.selectedDate, widget.restaurantManager.restaurantConfiguration!).toString(),
                style: TextStyle(fontSize: 16, color: globalGoldDark),  // Apply the globally defined style
              ),
              Text('/${widget.restaurantManager.restaurantConfiguration!.capacity}  ', style: const TextStyle(fontSize: 13, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
