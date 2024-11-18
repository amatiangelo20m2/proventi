import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../global/style.dart';
import '../../../../state_manager/restaurant_state_manager.dart';
import 'booking_processed_card.dart';

class ProcessedBookings extends StatefulWidget {
  const ProcessedBookings({super.key});

  @override
  State<ProcessedBookings> createState() => _ProcessedBookingsState();
}

class _ProcessedBookingsState extends State<ProcessedBookings> {
  String queryString = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context, RestaurantStateManager restaurantStateManager, Widget? child) {

        // Filter and group bookings by date
        final Map<DateTime, List<BookingDTO>> groupedBookings = _groupBookingsByDate(
          restaurantStateManager.allBookings!
              .where((booking) => booking.status == BookingDTOStatusEnum.ARRIVATO
              || booking.status == BookingDTOStatusEnum.ELIMINATO
              || booking.status == BookingDTOStatusEnum.NON_ARRIVATO)
              .toList());

        final Map<DateTime, List<BookingDTO>> sortedGroupedBookings =
        SplayTreeMap<DateTime, List<BookingDTO>>.from(
          groupedBookings,
              (a, b) => b.compareTo(a),
        );

        return RefreshIndicator(
          onRefresh: () async {
            await restaurantStateManager.refresh(DateTime.now());
          },
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 8, bottom: 3),
                  child: CupertinoTextField(
                    onChanged: (newQuery){
                      setState(() {
                        queryString = newQuery;
                      });
                    },

                    clearButtonMode: OverlayVisibilityMode.always,
                    placeholder: 'Ricerca per nome cliente o numero',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 160),
                  itemCount: sortedGroupedBookings.keys.length,
                  itemBuilder: (context, index) {
                    final date = sortedGroupedBookings.keys.elementAt(index);
                    final bookings = sortedGroupedBookings[date]!;
                
                    return _buildDateGroup(date, bookings, restaurantStateManager);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<DateTime, List<BookingDTO>> _groupBookingsByDate(List<BookingDTO> bookings) {
    final Map<DateTime, List<BookingDTO>> groupedBookings = {};

    for (var booking in bookings) {
      final date = DateTime(booking.bookingDate!.year,
          booking.bookingDate!.month,
          booking.bookingDate!.day);

      if (!groupedBookings.containsKey(date)) {
        groupedBookings[date] = [];
      }

      groupedBookings[date]!.add(booking);
    }

    // Sort groups by date (oldest first)
    final sortedKeys = groupedBookings.keys.toList()..sort((a, b) => a.compareTo(b));

    return {for (var key in sortedKeys) key: groupedBookings[key]!};
  }

  Widget _buildDateGroup(DateTime date, List<BookingDTO> bookings, RestaurantStateManager restaurantStateManager) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Prenotazioni processate di ${italianDateFormat.format(date)}'.toUpperCase(),
              style: TextStyle(
                  fontSize: 10,
                  color: globalGoldDark,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ...bookings.where((element) => element.customer!.firstName!
              .toLowerCase().contains(queryString.toLowerCase()) || element.customer!
              .phone!.toLowerCase().contains(queryString.toLowerCase())).map((booking) {
            return ProcessedBookingCard(
              booking: booking,
              formDTOs: restaurantStateManager.currentBranchForms!,
            );
          }).toList(),
        ],
      ),
    );
  }
}
