import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_customer_edit.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../global/flag_picker.dart';
import '../../../../global/style.dart';
import '../../../custom_widgets/profile_image_pro20/profile_image.dart';
import '../../../custom_widgets/whatsapp/chat_icon_whastapp.dart';
import '../bookings_utils.dart';

class BookingConfirmedCard extends StatelessWidget {
  final RestaurantDTO restaurantDTO;
  final BookingDTO booking;
  final List<FormDTO> forms;

  const BookingConfirmedCard(
      {super.key,
      required this.booking,
      required this.restaurantDTO,
        required this.forms});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBookingActionMenuConfermato(context, booking);
      },
      child: Dismissible(
        key: Key(booking.bookingCode.toString()),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            bool? result = await _showConfirmationDialog(
                context,
                'Conferma arrivo di ${booking.customer!.firstName!}?',
                'Si',
                'No');

            if (result == true) {
              return await _setAsArrivedReservation(context);
            }
          } else if (direction == DismissDirection.startToEnd) {
            // Asking confirmation for confirmation
            bool? result = await _showConfirmationDialog(context,
                '${booking.customer!.firstName!} non è arrivato?', 'Si', 'No');

            if (result == true) {
              return await _refuseReservation(context);
            }
          }
          return false;
        },
        background: _buildSwipeBackground(
          alignment: Alignment.centerLeft,
          color: CupertinoColors.destructiveRed,
          icon: CupertinoIcons.clear_circled,
        ),
        secondaryBackground: _buildSwipeBackground(
          alignment: Alignment.centerRight,
          color: CupertinoColors.activeGreen,
          icon: CupertinoIcons.check_mark_circled,
        ),
        child: _buildCardContent(context),
      ),
    );
  }

  Future<bool?> _setAsArrivedReservation(BuildContext context) async {
    Provider.of<RestaurantStateManager>(context, listen: false).updateBooking(
        BookingDTO(
            bookingCode: booking.bookingCode,
            status: BookingDTOStatusEnum.ARRIVATO), true);
    return false;
  }

  Future<bool?> _refuseReservation(BuildContext context) async {
    booking.status = BookingDTOStatusEnum.NON_ARRIVATO;
    Provider.of<RestaurantStateManager>(context, listen: false).updateBooking(
        BookingDTO(
            bookingCode: booking.bookingCode,
            status: BookingDTOStatusEnum.NON_ARRIVATO), true);
    _showSnackbar(
        context,
        'Prenotazione di ${booking.customer!.firstName!} aggiornata come non arrivata ❌');
    return false; // Prevent automatic dismissal
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildCardContent(BuildContext context) {
    return Column(
      children: [
        ListTile(
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
                avatarRadious: 25,
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
                    '${booking.customer!.firstName!.toUpperCase()} '
                        '${booking.customer!.lastName!.toUpperCase()} '
                        '${getFlagByPrefix(booking.customer!.prefix!)}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: blackDir,
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
                            '($currentBookingsOfTheCurrentCustomer)',
                            style: TextStyle(
                                color: blackDir, fontSize: 10),
                          ))
                          : const Icon(
                              Icons.fiber_new,
                              color: Colors.green,
                              size: 22,
                            );
                    },
                  ),
                  Text(getFormEmoji(forms, booking), style: const TextStyle(fontSize: 14),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      buildComponentGuest(booking.numGuests.toString()),
                      buildHourComponent(booking.timeSlot!),
                    ],
                  ),
                  Row(
                    children: [

                      ChatIconWhatsApp(
                        booking: booking, iconSize: 40
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: GestureDetector(
                            onTap: () {
                              showCupertinoModalBottomSheet(
                                expand: true,
                                elevation: 10,
                                context: context,
                                builder: (BuildContext context) {
                                  return BookingCustomerEdit(
                                    bookingDTO: booking,
                                    restaurantDTO: restaurantDTO,
                                    isAlsoBookingEditing: true,
                                    branchCode: booking.branchCode!,
                                  );
                                },
                              );
                            },
                            child: const Icon(CupertinoIcons.settings_solid)),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (booking.specialRequests != null && booking.specialRequests!.isNotEmpty) ...[
                    Text('💬${booking.specialRequests}', style: TextStyle(fontSize: 12, color: Colors.grey.shade700),),
                  ],
                  if (booking.privateNotes != null && booking.privateNotes!.isNotEmpty) ...[
                    Text('🤵‍${booking.privateNotes}', style: TextStyle(fontSize: 12,  color: Colors.grey.shade700),),
                  ],
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade300,
        ),
      ],
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
                  Text('Stato:${booking.status!.value}'),
                  Text('Data inserimento: ${DateFormat('dd-MM-yyyy HH:mm').format(booking.createdAt!)}'),
                  Text('Processata da: ${booking.processedBy ?? 'N/A'}'),
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
          if(booking.bookingDate!.isBefore(DateTime.now())) CupertinoActionSheetAction(
            onPressed: () async {
              bool? isArrivedConfirmeed = await _showConfirmationDialog(context,
                  'Segna ${booking.customer!.firstName!} come arrivato?', 'Si', 'No');

              if(isArrivedConfirmeed!){
                Provider.of<RestaurantStateManager>(context, listen: false)
                    .updateBooking(BookingDTO(
                    bookingCode: booking.bookingCode,
                    status: BookingDTOStatusEnum.ARRIVATO), false);
              }

              Navigator.pop(context, null);
            },
            child: const Text('Arrivato'),
          ),
          if(booking.bookingDate!.isBefore(DateTime.now())) CupertinoActionSheetAction(
            onPressed: () async {
              bool? isNotArrivedConfirmeed = await _showConfirmationDialog(context,
                  'Segna ${booking.customer!.firstName!} come non arrivato?', 'Si', 'No');
              if(isNotArrivedConfirmeed!){
                Provider.of<RestaurantStateManager>(context, listen: false)
                    .updateBooking(BookingDTO(
                    bookingCode: booking.bookingCode,
                    status: BookingDTOStatusEnum.NON_ARRIVATO), false);
              }
              Navigator.pop(context, null);
            },
            child: const Text('Non arrivato'),
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
            child: Text('Elimina', style: TextStyle(color: elegantRed)),
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
}
