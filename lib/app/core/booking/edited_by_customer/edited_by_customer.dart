import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../state_manager/restaurant_state_manager.dart';
import 'edited_by_customer_card.dart';

class BookingEditedByCustomer extends StatefulWidget {
  const BookingEditedByCustomer({super.key});

  @override
  State<BookingEditedByCustomer> createState() => _BookingEditedByCustomerState();
}

class _BookingEditedByCustomerState extends State<BookingEditedByCustomer> {
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
              .where((booking) => booking.status == BookingDTOStatusEnum.MODIFICATO_DA_UTENTE)
              .toList(),
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
                      left: 10, right: 10, top: 2, bottom: 3),
                  child: CupertinoTextField(
                    onChanged: (newQuery){
                      setState(() {
                        queryString = newQuery;
                      });
                    },

                    clearButtonMode: OverlayVisibilityMode.always,
                    placeholder: 'Ricerca per nome cliente o numero',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 160),
                  itemCount: groupedBookings.keys.length,
                  itemBuilder: (context, index) {
                    final date = groupedBookings.keys.elementAt(index);
                    final bookings = groupedBookings[date]!;
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

  Widget _buildDateGroup(DateTime date,
      List<BookingDTO> bookings,
      RestaurantStateManager restaurantStateManager) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Prenotazioni modificate',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ...bookings.where((element) => element.customer!.firstName!
              .toLowerCase().contains(queryString.toLowerCase()) || element.customer!.phone!.toLowerCase().contains(queryString.toLowerCase())).map((booking) {
            return ReservationEditedByCustomerCard(
              booking: booking,
              formDTOs: restaurantStateManager.currentBranchForms!,
            );
          }),
        ],
      ),
    );
  }
}
