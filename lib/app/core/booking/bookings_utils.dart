
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../api/restaurant_client/lib/api.dart';


List<BookingDTO> getBookingListFilteredByStatus(List<BookingDTO> list, List<BookingDTOStatusEnum> bookingStatus){
  return list
      .where((element) => bookingStatus.contains(element.status)).toList();
}

buildComponentGuest(String numGuests){
  return Container(
    width: 45,
    height: 25,
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(11),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.person_2, size: 20, color: Colors.white,),
          Text(
            numGuests,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

}