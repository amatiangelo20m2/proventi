import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_customer_edit.dart';
import 'package:proventi/app/custom_widgets/whatsapp/whatsapp_chat.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../global/flag_picker.dart';
import '../../../custom_widgets/whatsapp/chat_icon_whastapp.dart';
import '../bookings_utils.dart';

class ProcessedBookingCard extends StatelessWidget {
  final BookingDTO booking;
  final List<FormDTO> formDTOs;

  const ProcessedBookingCard({required this.booking,
    required this.formDTOs});

  void _showBookingActionMenu(
      BuildContext context, BookingDTO booking) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                      'Prenotazione di\n${booking.customer!.firstName!} ${booking.customer!.lastName!}'),
                  Text(booking.customer!.phone!),
                  Text(booking.customer!.email!),
                  Text(booking.formCode!),
                  Text('Stato:${booking.status!.value}'.replaceAll('_', ' ')),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.phone)),
            ),
          ],
        ),
        actions: [
          if (booking.bookingDate!.isAfter(DateTime.now().subtract(Duration(days: 2))))
          CupertinoActionSheetAction(
            onPressed: () async {

              bool confirmed = await _showConfirmationDialog(context, 'Sposta prenotazione di ${booking.customer!.firstName} fra le confermate?', '');

              if(confirmed){
                Provider.of<RestaurantStateManager>(context, listen: false)
                    .updateBooking(BookingDTO(
                    bookingCode: booking.bookingCode,
                    status: BookingDTOStatusEnum.CONFERMATO), false);
              }

              Navigator.pop(context, null);
            },
            child: const Text('Sposta prenotazione in CONFERMATE'),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        _showBookingActionMenu(context, booking);
      },
      child: ListTile(
        leading: ProfileImage(
          allowNavigation: true,
          customer: booking.customer!,
          branchCode: booking.branchCode!,
          avatarRadious: 25,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${booking.customer!.firstName!.toUpperCase()} ${booking.customer!.lastName!.toUpperCase()} ${getFlagByPrefix(booking.customer!.prefix!)}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: elegantBlue,
                  ),
                ),
                Row(
                  children: [
                    buildComponentGuest(booking.numGuests.toString()),
                    Text('🕖${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[900]),),
                  ],
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChatIconWhatsApp(
                booking: booking, iconSize: 40
              ),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(getIconByStatus(booking.status!), style: const TextStyle(fontSize: 15)),
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context, String title, String content) {
    return showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Si'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

}
