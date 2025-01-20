
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../api/restaurant_client/lib/api.dart';
import '../../../global/style.dart';

TextStyle globalStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.bold,
  color: Colors.grey.shade900
);

List<BookingDTO> getBookingListFilteredByStatus(List<BookingDTO> list, List<BookingDTOStatusEnum> bookingStatus){
  return list
      .where((element) => bookingStatus.contains(element.status)).toList();
}

buildComponentGuest(String numGuests){
  return Padding(
    padding: const EdgeInsets.only(left: 3, right: 13),
    child: Row(
      children: [
        Icon(CupertinoIcons.person_2, color: blackDir, size : 20),
        Text(
          ' $numGuests',
          style: globalStyle
        ),
      ],
    ),
  );
}


buildHourComponent(TimeSlot timeSlot){
 return Row(
   children: [
     Icon(CupertinoIcons.clock, color: Colors.grey.shade700, size: 18,),
     Text('${timeSlot.bookingHour!}:${NumberFormat("00").format(timeSlot.bookingMinutes!)}', style: globalStyle,),
   ],
 );
}