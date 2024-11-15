import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_edit.dart';
import 'package:proventi/app/core/whatsapp/dash_chat.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:badges/badges.dart' as badges;

class ReservationCard extends StatelessWidget {
  final BookingDTO booking;
  final List<FormDTO> formDTOs;

  const ReservationCard({required this.booking,
    required this.formDTOs});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch(booking.status){
          case BookingDTOStatusEnum.IN_ATTESA:
            _showBookingActionMenuListaAttesta(context, booking);
            break;
          case BookingDTOStatusEnum.CONFERMATO:
            _showBookingActionMenuConfermato(context, booking);
            break;
          case BookingDTOStatusEnum.RIFIUTATO:
            _showBookingActionMenuRifiutato(context, booking);
            break;
        }

      },
      child: Dismissible(
        key: Key(booking.bookingCode.toString()),
        confirmDismiss: (direction) async {
          // Show the confirmation dialog based on the swipe direction
          if (direction == DismissDirection.endToStart) {
            // Asking confirmation for cancellation
            bool? result = await _showConfirmationDialog(context, 'Conferma arrivo di ${booking.customer!.firstName!}?', 'Si', 'No' );

            if (result == true) {
              return await _setAsArrivedReservation(context);
            }
          } else if (direction == DismissDirection.startToEnd) {
            // Asking confirmation for confirmation
            bool? result = await _showConfirmationDialog(context, '${booking.customer!.firstName!} non è arrivato?', 'Si', 'No');

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

    Provider.of<RestaurantStateManager>(context, listen: false)
        .updateBooking(BookingDTO(
        bookingCode: booking.bookingCode,
        status: BookingDTOStatusEnum.ARRIVATO
    ));
    _showSnackbar(context, 'Prenotazione di ' + booking.customer!.firstName! + ' confermata ✅' );
    return false;
  }

  Future<bool?> _refuseReservation(BuildContext context) async {
    booking.status = BookingDTOStatusEnum.NON_ARRIVATO;
    Provider.of<RestaurantStateManager>(context, listen: false)
        .updateBooking(BookingDTO(
        bookingCode: booking.bookingCode,
        status: BookingDTOStatusEnum.NON_ARRIVATO
    ));
    _showSnackbar(context, 'Prenotazione di ' + booking.customer!.firstName! + ' aggiornata come non arrivata ❌' );
    return false; // Prevent automatic dismissal
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              _buildCustomerInfo(),
              Text(getFormEmoji(formDTOs, booking)),
              _buildGuestInfo(),
              Row(
                children: [
                  GestureDetector(child: badges.Badge(
                      showBadge: booking.specialRequests?.isNotEmpty ?? false,
                      child: const Icon(CupertinoIcons.doc_plaintext)), onTap: () {
                    if(booking.specialRequests?.isNotEmpty ?? false){
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text('Note'),
                            content: Text(booking.specialRequests!),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text("Chiudi"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: IconButton(onPressed: (){
                      showCupertinoModalBottomSheet(
                        expand: true,
                        elevation: 10,
                        context: context,
                        builder: (BuildContext context) {
                          return BookingEdit(bookingDTO: booking,);
                        },
                      );
                    }, icon: const Icon(CupertinoIcons.settings_solid)),
                  ),
                  Consumer<CommunicationStateManager>(
                    builder: (BuildContext context, CommunicationStateManager value, Widget? child) {
                      return IconButton(onPressed: () {
                        showCupertinoModalBottomSheet(
                          expand: true,
                          elevation: 10,
                          context: context,
                          builder: (BuildContext context) {
                            return DashChatCustomized20(bookingDTO: booking,);
                          },
                        );

                      }, icon: badges.Badge(

                          badgeContent: Text(value.chatDataSet!.length.toString(),),
                          child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green)),);
                    },)
                ],
              ),
              _buildStatusButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCustomerInfo() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.customer!.firstName!,
              style: TextStyle(
                fontSize: 14,
                decoration: booking.status == BookingDTOStatusEnum.NON_ARRIVATO ?
                TextDecoration.lineThrough : TextDecoration.none,
                color: Colors.blueGrey.shade900,
              ),
            ),
            Text(
              booking.customer?.lastName ?? '',
              style: TextStyle(
                decoration: booking.status == BookingDTOStatusEnum.NON_ARRIVATO ?
                TextDecoration.lineThrough : TextDecoration.none,
                fontSize: 11,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildTimeBooking(BuildContext context) {
    return Wrap(
      children: [
        const Icon(CupertinoIcons.clock, color: Colors.blueGrey,),
        Column(
          children: [
            Text(
              ' ${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
              style: TextStyle(
                fontSize: 13,

                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  CupertinoButton _buildStatusButton(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: getStatusColor(booking.status!),
      borderRadius: BorderRadius.circular(8),
      onPressed: () {

      },
      child: Text(
        booking.status!.value.toString().replaceAll('_', ' '),
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Row _buildGuestInfo() {
    return Row(
      children: [
        Icon(CupertinoIcons.person_2, color: Colors.blueGrey.shade900),
        const SizedBox(width: 2),
        Text(
          ' ${booking.numGuests ?? 0}',
          style: const TextStyle(
            fontSize: 13,
            color: CupertinoColors.label,
          ),
        ),
        const SizedBox(width: 12),
        Icon(CupertinoIcons.clock, color: Colors.blueGrey.shade900),
        const SizedBox(width: 2),
        Text(
          '${booking.timeSlot!.bookingHour.toString()}:${booking.timeSlot!.bookingHour}',
          style: const TextStyle(
            fontSize: 13,
            color: CupertinoColors.label,
          ),
        ),
      ],
    );
  }

  Widget _buildSwipeBackground({required Alignment alignment, required Color color, required IconData icon}) {
    return Container(
      alignment: alignment,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: color, size: 28),
    );
  }

  void _showBookingActionMenuListaAttesta(BuildContext context, BookingDTO booking) {
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
                  bookingId: booking.bookingId,
                  status: BookingDTOStatusEnum.RIFIUTATO
              ));
              Navigator.pop(context, null);

            },
            child: Text('Rifiuta prenotazione'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                bookingCode: booking.bookingCode,
                bookingId: booking.bookingId,
                status: BookingDTOStatusEnum.ELIMINATO
              ));
              Navigator.pop(context, null);
            },
            child: Text('Cancella'),
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
  void _showBookingActionMenuConfermato(BuildContext context, BookingDTO booking) {
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
                status: BookingDTOStatusEnum.ARRIVATO
              ));
              Navigator.pop(context, null);
            },
            child: const Text('Arrivato'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                  bookingCode: booking.bookingCode,
                  status: BookingDTOStatusEnum.NON_ARRIVATO
              ));
              Navigator.pop(context, null);
            },
            child: const Text('Non arrivato'),
          ),


          CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                bookingCode: booking.bookingCode,
                bookingId: booking.bookingId,
                status: BookingDTOStatusEnum.ELIMINATO
              ));
              Navigator.pop(context, null);
            },
            child: Text('Elimina'),
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
                  status: BookingDTOStatusEnum.ARRIVATO
              ));
              Navigator.pop(context, null);
            },
            child: const Text('Conferma Arrivo'),
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
  Future<bool?> _showConfirmationDialog(BuildContext context, String message, String confirmText, String goBackText) async {
    return await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(message, style: TextStyle(fontSize: 15),),
          actions: [
            CupertinoDialogAction(
              child: Text(goBackText),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if the user cancels
              },
            ),
            CupertinoDialogAction(
              child: Text(confirmText),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if the user confirms
              },
            ),
          ],
        );
      },
    );
  }

  String retrieveFlagByCountryCode(String prefix) {
    return '';
  }
}
