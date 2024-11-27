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

      List<BookingDTO> refusedBookings = getBookingListFilteredByStatus(widget.bookingList, BookingDTOStatusEnum.RIFIUTATO);

      if(refusedBookings.isNotEmpty) {
        return InkWell(
          onTap: () {
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
                          }, icon: Icon(Icons.clear))
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
          child: const Padding(
            padding:
            EdgeInsets.only(left: 30, top: 5, bottom: 5),
            child: Row(
              children: [
                badges.Badge(child: Icon(CupertinoIcons.archivebox)),
                Text(
                  'Prenotazioni rifiutate  ',
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        );
      }else{
        return SizedBox(height: 0,);
      }
    });
  }
}
