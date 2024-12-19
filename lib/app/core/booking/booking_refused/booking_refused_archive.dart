import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_refused/refused_booking_card.dart';
import 'package:proventi/global/style.dart';
import '../../../../api/restaurant_client/lib/api.dart';
import '../bookings_utils.dart';
import 'package:badges/badges.dart' as badges;

class RefusedBookingArchive extends StatefulWidget {
  const RefusedBookingArchive({super.key,
    required this.bookingList,
    required this.dateTime});

  final List<BookingDTO> bookingList;
  final DateTime dateTime;

  @override
  State<RefusedBookingArchive> createState() => _RefusedBookingArchiveState();
}

class _RefusedBookingArchiveState extends State<RefusedBookingArchive> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext builderContext){

      List<BookingDTO> refusedBookings = getBookingListFilteredByStatus(widget.bookingList, [BookingDTOStatusEnum.RIFIUTATO, BookingDTOStatusEnum.MODIFICA_RIFIUTATA]);

      if(refusedBookings.isNotEmpty) {
        return Stack(
          children: [
            IconButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  expand: true,
                  elevation: 10,
                  context: context,
                  builder: (BuildContext context) {
                    return Material(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  Prenotazioni rifiutate del ${italianDateFormat.format(widget.dateTime)}'),
                              IconButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, icon: const Icon(Icons.clear))
                            ],
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
              },
              icon: const Icon(CupertinoIcons.archivebox, size: 30),
            ),
            const Positioned(right: 0, top: 0, child: Icon(Icons.circle, size: 15, color: Colors.red))
          ]
        );
      }else{
        return const SizedBox(height: 0,);
      }
    });
  }
}
