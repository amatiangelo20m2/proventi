import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';

import '../../whatsapp/chat_icon_whastapp.dart';
import '../../whatsapp/whatsapp_chat.dart';

class ReservationEditedByCustomerCard extends StatelessWidget {
  final BookingDTO booking;
  final List<FormDTO> formDTOs;

  const ReservationEditedByCustomerCard(
      {super.key, required this.booking, required this.formDTOs});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showActionMenu(context, booking);
      },
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ProfileImage(branchCode: booking.branchCode!,
                      avatarRadious: 30,
                      customer: booking.customer!,
                      allowNavigation: true),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${booking.customer!.firstName!} ${booking.customer!.lastName!}' ,
                        style: TextStyle(
                          fontSize: 12,
                          color: elegantBlue,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.settings_solid,
                              color: Colors.grey[900],
                            ),
                          ),
                          ChatIconWhatsApp(booking: booking,),
                          Text(getFormEmoji(formDTOs, booking)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: Card(
                  elevation: 5,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateWidget(),
                        _buildGuestInfo(),
                        _buildTimeBooking(),
                        Text(booking.specialRequests!, style: TextStyle(fontSize: 10),)
                      ],
                    ),
                  ),
                ),
              ),
              Text(getIconByStatus(booking.status!), style: TextStyle(fontSize: 20),),

            ],
          ),
        ),
      ),
    );
  }
  Row _buildTimeBooking() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          CupertinoIcons.clock, color: Colors.black,
        ),
        booking.timeSlot?.bookingHour ==
                    booking.timeSlotAfterUpdate?.bookingHour &&
                booking.timeSlot?.bookingMinutes ==
                    booking.timeSlotAfterUpdate?.bookingMinutes

            ? Text(
                ' ${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
                style: TextStyle(
                  fontSize: 13,
                  color: elegantBlue,
                ),
              ) : Row(
          children: [
            Text(
              ' ${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.lineThrough,
                color: Colors.redAccent.shade700,
              ),
            ),
            const Icon(Icons.arrow_forward),
            Text(
              ' ${NumberFormat("00").format(booking.timeSlotAfterUpdate?.bookingHour)}:${NumberFormat("00").format(booking.timeSlotAfterUpdate?.bookingMinutes)}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.green.shade700,
              ),
            ),
          ],
        )
      ],
    );
  }
  Row _buildGuestInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(CupertinoIcons.person_2, color: Colors.black,),
        const SizedBox(width: 5),
        booking.numGuests != booking.numGuestsAfterUpdate ? Row(
          children: [
            Text(
              ' ${booking.numGuests ?? 0}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 13,
                color: Colors.redAccent.shade700,
              ),
            ),
            const Icon(Icons.arrow_forward),
            Text(
              ' ${booking.numGuestsAfterUpdate ?? 0}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ) : Text(
          ' ${booking.numGuests ?? 0}',
          style: const TextStyle(
            fontSize: 13,
            color: CupertinoColors.label,
          ),
        )

      ],
    );
  }

  void showActionMenu(BuildContext context, BookingDTO booking) {
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
                      'Gestisci prenotazione di\n${booking.customer!.firstName!} ${booking.customer!.lastName!}'),
                  Text(booking.customer!.phone!),
                  Text(booking.customer!.email!),
                  Text(booking.formCode!),
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
          if(booking.status == BookingDTOStatusEnum.MODIFICATO_DA_UTENTE) CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                      bookingCode: booking.bookingCode,
                      numGuests: booking.numGuestsAfterUpdate,
                      timeSlot: booking.timeSlotAfterUpdate,
                      bookingDate: booking.bookingDateAfterUpdate!.add(const Duration(hours: 12)),
                      status: BookingDTOStatusEnum.MODIFICA_CONFERMATA));
              Navigator.pop(context, null);
            },
            child: const Text('Conferma modifica'),
          ),
          if(booking.status == BookingDTOStatusEnum.MODIFICATO_DA_UTENTE) CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                      bookingCode: booking.bookingCode,
                      bookingId: booking.bookingId,
                      status: BookingDTOStatusEnum.MODIFICA_RIFIUTATA));
              Navigator.pop(context, null);
            },
            child: const Text('Rifiuta modifica'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                      bookingCode: booking.bookingCode,
                      bookingId: booking.bookingId,
                      status: BookingDTOStatusEnum.ELIMINATO));
              Navigator.pop(context, null);
            },
            child: Text('Elimina'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            // Close without any action
          },
          isDefaultAction: true,
          child: const Text('Indietro'),
        ),
      ),
    );
  }

  _buildDateWidget() {
    return !isSameDay(booking.bookingDate!, booking.bookingDateAfterUpdate!) ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(CupertinoIcons.calendar_today),
        Text('${booking.bookingDate!.day}/${booking.bookingDate!.month}', style: const TextStyle( decoration: TextDecoration.lineThrough,color: Colors.red),),
        const Icon(CupertinoIcons.arrow_right_circle, color: Colors.grey,),
        Text('${booking.bookingDateAfterUpdate!.day}/${booking.bookingDateAfterUpdate!.month}', style: TextStyle(color: Colors.green.shade700),),
      ],
    ) : Text('${booking.bookingDate!.day}/${booking.bookingDate!.month}');
  }
}
