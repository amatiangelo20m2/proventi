import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../global/flag_picker.dart';
import '../../../custom_widgets/whatsapp/chat_icon_whastapp.dart';
import '../../customer/customer_state_manager.dart';
import '../bookings_utils.dart';

class ReservationEditedByCustomerCard extends StatelessWidget {
  final BookingDTO booking;
  final List<FormDTO> formDTOs;

  const ReservationEditedByCustomerCard(
      {super.key,
        required this.booking,
        required this.formDTOs});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBookingActionMenuConfermato(context, booking);
      },
      child: _buildCardContent(context)
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return ListTile(
      leading: Consumer<CustomerStateManager>(
        builder: (BuildContext context,
            CustomerStateManager customerStateManager, Widget? child) {
          int noShowBookings = 0;

          if (customerStateManager.historicalCustomerData!
              .where((element) =>
          element.customerDTO!.customerId ==
              booking.customer!.customerId!)
              .isNotEmpty) {
            CustomerHistoryDTO customerHistoryDTO = customerStateManager
                .historicalCustomerData!
                .where((element) =>
            element.customerDTO!.customerId ==
                booking.customer!.customerId!)
                .first;
            noShowBookings = customerHistoryDTO.historicalNoShowsNumber!;
          }
          return ProfileImage(
            allowNavigation: true,
            customer: booking.customer!,
            branchCode: booking.branchCode!,
            avatarRadious: 30,
            noShowBookings: noShowBookings,
          );
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${booking.customer!.firstName!.toUpperCase()} ${booking.customer!.lastName!.toUpperCase()} ${getFlagByPrefix(booking.customer!.prefix!)}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.013,
                  fontWeight: FontWeight.bold,
                  color: elegantBlue,
                ),
              ),
              Consumer<CustomerStateManager>(
                builder: (BuildContext context,
                    CustomerStateManager customerStateManager, Widget? child) {
                  int currentBookingsOfTheCurrentCustomer = 0;

                  if (customerStateManager.historicalCustomerData!
                      .where((element) =>
                  element.customerDTO!.customerId ==
                      booking.customer!.customerId!)
                      .isNotEmpty) {
                    CustomerHistoryDTO customerHistoryDTO = customerStateManager
                        .historicalCustomerData!
                        .where((element) =>
                    element.customerDTO!.customerId ==
                        booking.customer!.customerId!)
                        .first;
                    currentBookingsOfTheCurrentCustomer =
                    customerHistoryDTO.historicalBookingsNumber!;
                  }

                  return currentBookingsOfTheCurrentCustomer > 1
                      ? Center(
                      child: Text(
                        '(' + currentBookingsOfTheCurrentCustomer.toString() + ')',
                        style: TextStyle(
                            color: blackDir, fontSize: 10),
                      ))
                      : const Icon(
                    Icons.fiber_new,
                    color: Colors.green,
                    size: 30,
                  );
                },
              ),
              Text(getFormEmoji(formDTOs, booking), style: TextStyle(fontSize: 13),),
            ],
          ),

          Card(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: Column(
              children: [
                buildDateComponent(booking.bookingDate!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    buildComponentGuest(booking.numGuests.toString()),
                    buildHourComponent(booking.timeSlot!),
                  ],
                ),
              ],
            ),
          ),
          Center(child: Icon(Icons.arrow_downward, color: Colors.grey.shade700, size: 20,)),
          Stack(
            children: [
              Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Column(
                  children: [
                    buildDateComponent(booking.bookingDateAfterUpdate!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        buildComponentGuest(booking.numGuestsAfterUpdate.toString()),
                        buildHourComponent(booking.timeSlotAfterUpdate!),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(right: 0, child: Icon(
                Icons.fiber_new,
                color: Colors.green,
                size: 30,
              ))
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (booking.specialRequests != null && booking.specialRequests!.isNotEmpty) ...[
                Text('💬${booking.specialRequests}', style: const TextStyle(fontSize: 12),),
              ],
              if (booking.privateNotes != null && booking.privateNotes!.isNotEmpty) ...[
                Text('🤵‍${booking.privateNotes}', style: const TextStyle(fontSize: 12),),
              ],
            ],
          ),
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      trailing: ChatIconWhatsApp(booking: booking,),
    );
  }

  Widget _buildSwipeBackground(
      {required Alignment alignment,
        required Color color,
        required IconData icon}) {
    return Container(
      alignment: alignment,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: color, size: 28),
    );
  }

  void _showBookingActionMenuConfermato(
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
                      'Gestisci prenotazione di\n${booking.customer!.firstName!} ${booking.customer!.lastName!}'),
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
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context, null);

              bool? isArrivedConfirmeed = await _showConfirmationDialog(context,
                  'Conferma le modifiche effettuate da ${booking.customer!.firstName!}?', 'Si', 'No');

              if(isArrivedConfirmeed!){
                Provider.of<RestaurantStateManager>(context, listen: false)
                    .updateBooking(BookingDTO(
                    bookingCode: booking.bookingCode,
                    numGuests: booking.numGuestsAfterUpdate,
                    timeSlot: booking.timeSlotAfterUpdate,
                    bookingDate: booking.bookingDateAfterUpdate!.add(const Duration(hours: 12)),
                    status: BookingDTOStatusEnum.MODIFICA_CONFERMATA), false);
              }

              Navigator.pop(context, null);
            },
            child: const Text('Accetta modifica'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              bool? isNotArrivedConfirmeed = await _showConfirmationDialog(context,
                  'Rifiuta le modifiche di ${booking.customer!.firstName!}?', 'Si', 'No');
              if(isNotArrivedConfirmeed!){
                Provider.of<RestaurantStateManager>(context, listen: false)
                    .updateBooking(BookingDTO(
                    bookingCode: booking.bookingCode,
                    status: BookingDTOStatusEnum.MODIFICA_RIFIUTATA), false);
              }
              Navigator.pop(context, null);
            },
            child: const Text('Rifiuta modifica'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              bool? deleteBooking = await _showConfirmationDialog(context,
                  'Eliminare la prenotazione di ${booking.customer!.firstName!}?', 'Si', 'No');
              if(deleteBooking!){
                bool? result = await _showConfirmationDialog(context,
                    'Invia messaggio ${booking.customer!.firstName!}?', 'Si', 'No');

                Provider.of<RestaurantStateManager>(context, listen: false)
                    .updateBooking(BookingDTO(
                    bookingCode: booking.bookingCode,
                    bookingId: booking.bookingId,
                    status: BookingDTOStatusEnum.ELIMINATO), result!);
                Navigator.pop(context, null);
              }else{
                Navigator.pop(context, null);
              }
            },
            child: const Text('Elimina'),
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


  Future<bool?> _showConfirmationDialog(BuildContext context, String message,
      String confirmText, String goBackText) async {
    return await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(goBackText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoDialogAction(
              child: Text(confirmText),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  buildDateComponent(DateTime dateTime) {
    return Text(italianDateFormat.format(dateTime).toUpperCase(),
        style: const TextStyle(fontSize: 7));
  }
}
