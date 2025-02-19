import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/global/style.dart';
import '../../../../../api/restaurant_client/lib/api.dart';
import '../../bookings_utils.dart';

buildCurrentDaySituationWidget(List<BookingDTO> list, bool isSelected) {
  int bookings = getBookingListFilteredByStatus(list, [BookingDTOStatusEnum.CONFERMATO, BookingDTOStatusEnum.MODIFICA_RIFIUTATA, BookingDTOStatusEnum.MODIFICA_CONFERMATA]).length;

  int refused = getBookingListFilteredByStatus(list, [BookingDTOStatusEnum.RIFIUTATO]).length;

  if (bookings == 0 && refused == 0) {
    return const SizedBox(
      height: 0,
    );
  }
  return Positioned(
    right: 0,
    child: Column(
      children: [
        if (bookings > 0)
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.book_circle,
                        size: 18,
                        color: Colors.white),
                    Text(
                      '$bookings',
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 2,
        ),
        if (refused > 0)
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                color: elegantRed,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.clear_circled,
                        size: 18,
                        color: Colors.white),
                    Text(
                      '$refused',
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}