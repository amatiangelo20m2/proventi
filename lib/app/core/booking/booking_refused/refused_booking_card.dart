import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../custom_widgets/whatsapp/chat_icon_whastapp.dart';
import '../../home_screen.dart';
import '../bookings_utils.dart';

class RefusedBookingCard extends StatelessWidget {
  final BookingDTO booking;

  const RefusedBookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBookingActionMenuRifiutato(context, booking);

      },
      child: _buildCardContent(context)
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ProfileImage(
                    allowNavigation: true,
                    customer: booking.customer!,
                    branchCode: booking.branchCode!,
                    avatarRadious: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${booking.customer!.firstName!} ${booking.customer!.lastName!}',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: booking.status == BookingDTOStatusEnum.NON_ARRIVATO ? TextDecoration.lineThrough : TextDecoration.none,
                            color: elegantBlue,
                          ),
                        ),
                        _buildGuestInfo(),
                        if((booking.specialRequests?.isNotEmpty ?? false)) Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Stack(children: [
                                Text('💬', style: TextStyle(fontSize: 14),),
                                Positioned(right: -1, child: Icon(Icons.circle, size: 10, color: Colors.redAccent,))
                              ]),
                            ),
                            Text(booking.specialRequests!, style: TextStyle(fontSize: 11, color: Colors.grey[800]),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              ChatIconWhatsApp(booking: booking,),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildGuestInfo() {
    return Row(
      children: [
        buildComponentGuest(booking.numGuests.toString()),

        const SizedBox(width: 12),
        Text(
          ' 🕓${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
          style: TextStyle(
            fontSize: 13,

            color: elegantBlue,
          ),
        ),
      ],
    );
  }

  void _showBookingActionMenuRifiutato(BuildContext context, BookingDTO booking) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('Gestisci prenotazione di\n${booking.customer!.firstName!} ${booking.customer!.lastName!}'),
                  Text(booking.customer!.phone!),
                  Text(booking.customer!.email!),
                  Text(booking.formCode!),
                  Text('Stato:' + booking.status!.value),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(onPressed: () {
              }, icon: Icon(CupertinoIcons.phone)),
            ),
          ],
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                  bookingCode: booking.bookingCode,
                  status: BookingDTOStatusEnum.CONFERMATO
              ), true);

              Fluttertoast.showToast(
                msg: "La prenotazione di " +booking.customer!.firstName! + ' è stata spostata fra quelle confermate ed il cliente notificato',
                toastLength: Toast.LENGTH_LONG,
                fontSize: 18.0,
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen(pageIndex: 0,)),
              );
            },
            child: const Text('Converti in CONFERMATA'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
          child: const Text('Indietro'),
        ),
      ),
    );
  }
}
