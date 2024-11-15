
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/restaurant_client/lib/api.dart';

Wrap buildTimeBooking(BookingDTO booking) {
  return Wrap(
    children: [
      const Icon(CupertinoIcons.clock, color: Colors.blueGrey,),
      Column(
        children: [
          Text(
            ' ${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
            style: TextStyle(
              fontSize: 13,

              color: Colors.blueGrey.shade900,
            ),
          ),
        ],
      ),
    ],
  );
}