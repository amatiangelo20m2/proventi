import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../api/restaurant_client/lib/api.dart';
import '../../bookings_utils.dart';

buildCurrentDaySituationWidget(List<BookingDTO> list, bool isSelected) {
  int bookings = getBookingListFilteredByStatus(list, BookingDTOStatusEnum.CONFERMATO).length;

  int refused = getBookingListFilteredByStatus(list, BookingDTOStatusEnum.RIFIUTATO).length;

  if (bookings == 0 && refused == 0) {
    return SizedBox(
      height: 0,
    );
  }
  return Positioned(
      right: 0,
      child: Column(
        children: [
          if (bookings > 0)
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(
                    5), // Half of width/height for a circular effect
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.book,
                        size: 13, // Set the size of the icon
                        color: Colors.white),
                    Text(
                      ' $bookings', // Text to display inside the circle
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(
            height: 2,
          ),
          if(refused > 0) Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(
                  5), // Half of width/height for a circular effect
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.clear_circled,
                      size: 13, // Set the size of the icon
                      color: Colors.white),
                  Text(
                    ' $refused', // Text to display inside the circle
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
}