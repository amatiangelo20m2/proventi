import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_edit.dart';
import 'package:proventi/app/core/whatsapp/whatsapp_chat.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../api/communication_client/lib/api.dart';
import '../../../../global/date_methods_utility.dart';
import '../../../../global/flag_picker.dart';
import '../../../custom_widgets/profile_image.dart';

class BookingConfirmedCard extends StatelessWidget {
  final RestaurantDTO restaurantDTO;
  final BookingDTO booking;
  final Color shadeColor;

  const BookingConfirmedCard({super.key, required this.booking, required this.restaurantDTO, required this.shadeColor});

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
    return ListTile(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isLunchTime(booking, restaurantDTO) ? globalGoldDark : elegantBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '👥${booking.numGuests}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ProfileImage(prefix: booking.customer!.prefix!,
                    phone: booking.customer!.phone!,
                    branchCode: booking.branchCode!,
                    avatarRadious: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${booking.customer!.firstName!.toUpperCase()} ${booking.customer!.lastName!.toUpperCase()} ${getFlagByPrefix(booking.customer!.prefix!)}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                        Text('🕖 ${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
                          style: TextStyle(color: Colors.grey[900]),),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if(booking.specialRequests!.isNotEmpty) IconButton(
                    onPressed: (){
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
                    },
                    icon: Stack(
                      children: [
                        Icon(CupertinoIcons.doc_plaintext, color: Colors.grey.shade900,),
                        Positioned(right: 0, child: Icon(Icons.circle, size: 14, color: Colors.red,))
                      ],
                    ),
                  ),

                  Consumer<CommunicationStateManager>(
                    builder: (BuildContext context, CommunicationStateManager communication, Widget? child) {
                      return IconButton(onPressed: () {
                        showCupertinoModalBottomSheet(
                          expand: true,
                          elevation: 10,
                          context: context,
                          builder: (BuildContext context) {
                            return DashChatCustomized20(bookingDTO: booking,);
                          },
                        );

                      }, icon: Stack(children: [

                        const Icon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 25,),
                        if(checkIfChatsContainCurrentNumberWithUnreadChats(communication, booking.customer!)) Positioned(right: 0, child: Icon(Icons.circle, size: 14, color: Colors.red,))
                        ]),
                      );
                    },),
                  IconButton(onPressed: (){
                    showCupertinoModalBottomSheet(
                      expand: true,
                      elevation: 10,
                      context: context,
                      builder: (BuildContext context) {
                        return BookingEdit(bookingDTO: booking, restaurantDTO: restaurantDTO,);
                      },
                    );
                  }, icon: const Icon(CupertinoIcons.settings_solid)),
                ],
              ),
            ],
          ),
          Divider(indent: MediaQuery.of(context).size.width / 6, color: Colors.grey.shade300, height: 2,)
        ],
      ),
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
                  Text('Stato:${booking.status!.value}'),
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

  checkIfChatsContainCurrentNumberWithUnreadChats(CommunicationStateManager communication, CustomerDTO customer) {


    if(communication.chatList!.where((element) => element.fromNumber == '${booking.customer!.prefix}${booking.customer!.phone}@c.us').isNotEmpty){
      AllChatListDataDTO chatListDataDTO = communication.chatList!.where((element) => element.fromNumber == '${booking.customer!.prefix}${booking.customer!.phone}@c.us').first;
      if(chatListDataDTO.unreadCount! > 0) {
        return true;
      }
    }
    return false;

  }
}