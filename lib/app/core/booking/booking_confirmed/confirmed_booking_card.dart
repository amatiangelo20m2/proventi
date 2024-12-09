import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_customer_edit.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';
import 'package:proventi/app/core/whatsapp/whatsapp_chat.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../../global/flag_picker.dart';
import '../../../custom_widgets/profile_image.dart';
import '../../whatsapp/chat_icon_whastapp.dart';
import '../bookings_utils.dart';

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
      leading: Consumer<CustomerStateManager>(
        builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {

          int noShowBookings = 0;

          if(customerStateManager.historicalCustomerData!.where((element)
          => element.customerDTO!.customerId == booking.customer!.customerId!).isNotEmpty){
            CustomerHistoryDTO customerHistoryDTO = customerStateManager.historicalCustomerData!.where((element)
            => element.customerDTO!.customerId == booking.customer!.customerId!).first;
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
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  buildComponentGuest(booking.numGuests.toString()),
                  Text('  🕖${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
                    style: TextStyle(color: Colors.grey[900]),),
                  Consumer<CustomerStateManager>(
                      builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {

                        int currentBookingsOfTheCurrentCustomer = 0;

                        if(customerStateManager.historicalCustomerData!.where((element)
                        => element.customerDTO!.customerId == booking.customer!.customerId!).isNotEmpty){
                          CustomerHistoryDTO customerHistoryDTO = customerStateManager.historicalCustomerData!.where((element)
                          => element.customerDTO!.customerId == booking.customer!.customerId!).first;
                          currentBookingsOfTheCurrentCustomer = customerHistoryDTO.historicalBookingsNumber!;
                        }
                        return Card(
                            color: Colors.blueGrey,
                            child: Padding(
                              padding: EdgeInsets.only(left: 7, right: 7),
                              child: Center(child: Text(currentBookingsOfTheCurrentCustomer.toString(), style: TextStyle(color: Colors.white),)),
                            ));
                      },
                  ),
                ],
              ),
              Row(
                children: [
                  ChatIconWhatsApp(booking: booking,),

                  IconButton(onPressed: (){
                    showCupertinoModalBottomSheet(
                      expand: true,
                      elevation: 10,
                      context: context,
                      builder: (BuildContext context) {
                        return BookingCustomerEdit(
                          bookingDTO: booking,
                          restaurantDTO: restaurantDTO,
                          isAlsoBookingEditing: true,
                          branchCode: booking.branchCode!, );
                      },
                    );
                  }, icon: const Icon(CupertinoIcons.settings_solid)),
                ],
              ),
            ],
          ),
          if((booking.specialRequests?.isNotEmpty ?? false)) Text('💬 ${booking.specialRequests!}', style: TextStyle(fontSize: 11, color: Colors.grey[800]),),
          Divider(height: 2, color: Colors.grey.shade300, ),
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
