import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../global/style.dart';
import '../../../../state_manager/restaurant_state_manager.dart';
import '../../customer/customer_state_manager.dart';
import '../crud_widget/create_booking_lista_attesa.dart';
import 'fast_queue_card.dart';

class FastQueue extends StatefulWidget {
  const FastQueue({super.key});

  @override
  State<FastQueue> createState() => _FastQueueState();
}

class _FastQueueState extends State<FastQueue> {
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
              .where((booking) => (booking.status == BookingDTOStatusEnum.LISTA_ATTESA || booking.status == BookingDTOStatusEnum.AVVISATO_LISTA_ATTESA)
              && (booking.customer!.firstName!.toLowerCase().contains(queryString.toLowerCase().toString()) || booking.customer!.lastName!.toLowerCase().contains(queryString.toLowerCase().toString())))
              .toList(),
        );

        return RefreshIndicator(
          onRefresh: () async {
            await restaurantStateManager.refresh(DateTime.now());
          },
          child: Stack(children: [
            Column(
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
                      placeholder: 'Ricerca per nome cliente',
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
            Positioned(right: 0, bottom: 0, child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: FloatingActionButton(
                backgroundColor: elegantBlue,
                onPressed: () async {
                  await Provider.of<CustomerStateManager>(context, listen: false).refreshHistory();
                  showFormBottomSheet(context, BookingDTOStatusEnum.LISTA_ATTESA);
                },
                child: const Icon(CupertinoIcons.book, color: Colors.white,),),
            ))
          ],)
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
              'Prelazione su fila di ${italianDateFormat.format(date)}'.toUpperCase(),
              style: TextStyle(
                  fontSize: 13,
                  color: globalGoldDark,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ...bookings.map((booking) {
            return FastQueueCard(
              booking: booking,
            );
          }),
        ],
      ),
    );
  }

  void showFormBottomSheet(BuildContext context, BookingDTOStatusEnum bookingStatus) {

    showCupertinoModalBottomSheet(
      expand: true,
      elevation: 10,
      context: context,
      builder: (BuildContext context) {
        return CreateBookingListAttesa();
      },
    );
  }
}
