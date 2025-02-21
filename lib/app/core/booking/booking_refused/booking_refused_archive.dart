import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_refused/refused_booking_card.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:provider/provider.dart';
import '../../../../api/restaurant_client/lib/api.dart';
import '../bookings_utils.dart';
import 'package:badges/badges.dart' as badges;

class RefusedBookingArchive extends StatefulWidget {
  const RefusedBookingArchive({super.key,
    required this.dateTime});

  final DateTime dateTime;

  @override
  State<RefusedBookingArchive> createState() => _RefusedBookingArchiveState();
}

class _RefusedBookingArchiveState extends State<RefusedBookingArchive> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context, RestaurantStateManager restaurantStateManager, Widget? child) {

        List<BookingDTO> refusedBookings = getBookingListFilteredByStatus(restaurantStateManager.allBookings!.where((element) => isSameDay(
            element.bookingDate!,
            widget.dateTime)).toList(), [BookingDTOStatusEnum.RIFIUTATO]);

        if(refusedBookings.isNotEmpty) {
          return badges.Badge(
            child: GestureDetector(
              child: const Icon(CupertinoIcons.archivebox),
              onTap: () {
                showCupertinoModalBottomSheet(
                  expand: true,
                  elevation: 10,
                  context: context,
                  builder: (BuildContext context) {
                    return Material(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            color: blackDir,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('  Prenotazioni rifiutate di ${italianDateFormat.format(widget.dateTime)}', style: TextStyle(fontFamily: globalFontFamily, color: Colors.white),),
                                IconButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, icon: const Icon(Icons.clear, color: Colors.white,))
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: refusedBookings.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RefusedBookingCard(booking: refusedBookings.elementAt(index));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },),
          );
        }else{
          return const SizedBox(height: 0,);
        }
      },
    );
  }
}
