import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../global/style.dart';
import '../../../../../state_manager/restaurant_state_manager.dart';
import 'filter_daily_type.dart';

LinearProgressWidget(RestaurantStateManager? restaurantManager,
    DateTime day,
    FilterDailyType filterDailyType) {

  if(restaurantManager!.restaurantConfiguration == null){
    return const SizedBox(height: 0,);
  }
  if(restaurantManager.restaurantConfiguration!.capacity == null){
    return const SizedBox(height: 0,);
  }

  int pax = 0;
  if(filterDailyType == FilterDailyType.PRANZO){
    pax = restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookingsLunchTime(day, restaurantManager.restaurantConfiguration!);
  }else if(filterDailyType == FilterDailyType.CENA){
    pax = restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookingsDinnerTime(day, restaurantManager.restaurantConfiguration!);
  }

  double currentProgressValue = pax
      / restaurantManager.restaurantConfiguration!.capacity!;

  return LinearProgressIndicator(
    color: currentProgressValue > 1 ? Colors.redAccent : filterDailyType == FilterDailyType.PRANZO ? globalGoldDark : Colors.blueAccent,
    value: currentProgressValue,
  );
}
  