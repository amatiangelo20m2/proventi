import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';

import '../../../../global/style.dart';
import '../../../../state_manager/restaurant_state_manager.dart';
import 'booking_to_manage_card.dart';

class BookingManager extends StatefulWidget {
  const BookingManager({super.key});

  @override
  State<BookingManager> createState() => _BookingManagerState();
}

class _BookingManagerState extends State<BookingManager> {
  @override
  void initState() {
    super.initState();
  }

  String queryString = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context, RestaurantStateManager restaurantStateManager, Widget? child) {
        // Filter and group bookings by date
        final Map<DateTime, List<BookingDTO>> groupedBookings = _groupBookingsByDate(
          restaurantStateManager.allBookings!
              .where((booking) => booking.status == BookingDTOStatusEnum.IN_ATTESA)
              .toList(),
        );
        return RefreshIndicator(
          onRefresh: () async {
            await restaurantStateManager.refresh(DateTime.now());
          },
          child: Column(
            children: [
              Text(
                'Prenotazioni in attesa di conferma',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold),
              ),
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
                    placeholder: 'Ricerca per nome cliente',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              groupedBookings.isEmpty ?
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3,),
            child: Column(
              children: [
                Lottie.asset('assets/lotties/nocalendar.json'),
                Text('Non ci sono prenotazioni in attesa')
              ],
            ),
          ),
        ):
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 160),
                  itemCount: groupedBookings.keys.length,
                  itemBuilder: (context, index) {
                    final date = groupedBookings.keys.elementAt(index);
                    final bookings = groupedBookings[date]!;

                    return _buildDateGroup(
                        date,
                        bookings,
                        restaurantStateManager);
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

    //sorting date from the newst to the oldest reservation
    bookings.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🗓️ ${italianDateFormat.format(date)}'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text('👥${restaurantStateManager
                          .retrieveTotalGuestsNumberForDayAndActiveBookings(
                          date)}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: globalGoldDark),),
                      Text(
                        ' / ${restaurantStateManager
                            .restaurantConfiguration!.capacity}  ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),

                    ],
                  )
                ],
              ),

            ],
          ),
        ),
        ...bookings.where((element) => element.customer!.firstName
        !.toLowerCase().contains(queryString.toLowerCase())).map((booking) {
          return BookingToManageCard(
            booking: booking,
            formDTOs: restaurantStateManager.currentBranchForms!,
            restaurantDTO: restaurantStateManager.restaurantConfiguration!,
          );
        }).toList(),
      ],
    );
  }
}
