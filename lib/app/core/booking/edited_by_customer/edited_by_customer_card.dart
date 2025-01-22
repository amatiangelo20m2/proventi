import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../global/flag_picker.dart';
import '../../../custom_widgets/whatsapp/chat_icon_whastapp.dart';
import '../../customer/customer_state_manager.dart';

class ReservationEditedByCustomerCard extends StatelessWidget {
  final BookingDTO booking;
  final List<FormDTO> formDTOs;

  const ReservationEditedByCustomerCard({
    super.key,
    required this.booking,
    required this.formDTOs,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context, RestaurantStateManager restaurantManager, Widget? child) {
        return GestureDetector(
          onTap: () {
            _showBookingActionMenu(context, booking, restaurantManager);
          },
          child: Card(
            color: Colors.white,
            elevation: 8,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCardContent(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileImage(context),
            const SizedBox(width: 12),
            Expanded(child: _buildCustomerDetails(context)),
            ChatIconWhatsApp(booking: booking, iconSize: 40),
          ],
        ),
        const Divider(height: 20),
        _buildReservationDetails(context),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Consumer<CustomerStateManager>(
      builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {
        int noShowBookings = 0;

        if (customerStateManager.historicalCustomerData!
            .where((element) =>
        element.customerDTO!.customerId == booking.customer!.customerId!)
            .isNotEmpty) {
          CustomerHistoryDTO customerHistoryDTO = customerStateManager
              .historicalCustomerData!
              .where((element) =>
          element.customerDTO!.customerId == booking.customer!.customerId!)
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
    );
  }

  Widget _buildCustomerDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${booking.customer!.firstName!.toUpperCase()} ${booking.customer!.lastName!.toUpperCase()} ${getFlagByPrefix(booking.customer!.prefix!)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: elegantBlue,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildBookingCountIndicator(context),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '💬${booking.specialRequests!}',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildBookingCountIndicator(BuildContext context) {
    return Consumer<CustomerStateManager>(
      builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {
        int currentBookingsOfTheCurrentCustomer = 0;

        if (customerStateManager.historicalCustomerData!
            .where((element) =>
        element.customerDTO!.customerId == booking.customer!.customerId!)
            .isNotEmpty) {
          CustomerHistoryDTO customerHistoryDTO = customerStateManager
              .historicalCustomerData!
              .where((element) =>
          element.customerDTO!.customerId == booking.customer!.customerId!)
              .first;
          currentBookingsOfTheCurrentCustomer =
          customerHistoryDTO.historicalBookingsNumber!;
        }

        return currentBookingsOfTheCurrentCustomer > 1
            ? Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '(${currentBookingsOfTheCurrentCustomer.toString()})',
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
        )
            : const Icon(
          Icons.fiber_new,
          color: Colors.green,
          size: 20,
        );
      },
    );
  }

  Widget _buildReservationDetails(BuildContext context) {
    return Container(
      color:  booking.status == BookingDTOStatusEnum.ELIMINATO_DA_UTENTE
          ? Colors.redAccent.shade700 : Colors.white,
      child: Column(
        children: [
          _buildReservationInfo(booking.bookingDate!, booking.numGuests.toString(), booking.timeSlot!),
          if (booking.status == BookingDTOStatusEnum.ELIMINATO_DA_UTENTE)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'PRENOTAZIONE ELIMINATA DA UTENTE',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          else
            Column(
              children: [
                const Icon(Icons.arrow_circle_down_sharp, color: Colors.black, size: 23),
                _buildModifiedReservationInfo(
                  booking.bookingDateAfterUpdate!,
                  booking.numGuestsAfterUpdate.toString(),
                  booking.timeSlotAfterUpdate!,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildReservationInfo(DateTime date, String guests, TimeSlot timeSlot) {
    return _buildReservationCard(date, guests, timeSlot);
  }

  Widget _buildModifiedReservationInfo(DateTime date, String guests, TimeSlot timeSlot) {
    return _buildReservationCard(date, guests, timeSlot, isModified: true);
  }

  Widget _buildReservationCard(DateTime date, String guests, TimeSlot timeSlot, {bool isModified = false}) {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildDateComponent(date, isModified: isModified && date != booking.bookingDate),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 20, color: isModified ? Colors.green.shade700 : Colors.grey.shade700),
                    const SizedBox(width: 4),
                    buildComponentGuest(guests, isModified: isModified && guests != booking.numGuests.toString()),
                  ],
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.clock,  size: 20, color: isModified && (timeSlot.bookingHour != booking.timeSlot!.bookingHour || timeSlot.bookingMinutes != booking.timeSlot!.bookingMinutes) ? Colors.green.shade700 : Colors.grey.shade700),
                    const SizedBox(width: 4),
                    buildHourComponent(timeSlot, isModified: isModified && (timeSlot.bookingHour != booking.timeSlot!.bookingHour || timeSlot.bookingMinutes != booking.timeSlot!.bookingMinutes)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateComponent(DateTime dateTime, {bool isModified = false}) {
    return Text(
      italianDateFormat.format(dateTime).toUpperCase(),
      style: TextStyle(
        fontSize: 13,
        color: isModified ? Colors.green.shade500 : Colors.black,
        fontWeight: isModified ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget buildComponentGuest(String guests, {bool isModified = false}) {
    return Text(
      guests,
      style: TextStyle(
        fontSize: 14,
        color: isModified ? Colors.green.shade500 : Colors.black,
        fontWeight: isModified ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget buildHourComponent(TimeSlot timeSlot, {bool isModified = false}) {
    return Text(
      '${timeSlot.bookingHour}:${timeSlot.bookingMinutes}',
      style: TextStyle(
        fontSize: 14,
        color: isModified ? Colors.green.shade500 : Colors.black,
        fontWeight: isModified ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  void _showBookingActionMenu(
      BuildContext context,
      BookingDTO booking,
      RestaurantStateManager restaurantManager,
      ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Gestisci prenotazione di\n${booking.customer!.firstName!} ${booking.customer!.lastName!}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(booking.customer!.phone!),
            Text(booking.customer!.email!),

            Text('Stato: ${booking.status!.value.replaceAll('_', ' ')}'),
          ],
        ),
        actions: _buildActionMenuItems(context, booking, restaurantManager),
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

  List<Widget> _buildActionMenuItems(
      BuildContext context,
      BookingDTO booking,
      RestaurantStateManager restaurantManager,
      ) {
    List<Widget> actions = [];

    if (booking.status == BookingDTOStatusEnum.MODIFICATO_DA_UTENTE) {
      actions.addAll([
        CupertinoActionSheetAction(
          onPressed: () async {
            bool? confirm = await _showConfirmationDialog(
              context,
              'Conferma le modifiche effettuate da ${booking.customer!.firstName!}?',
              'Si',
              'No',
            );

            if (confirm == true) {
              final prefs = await SharedPreferences.getInstance();
              String? userName = await prefs.getString('username');

              restaurantManager.updateBooking(
                BookingDTO(
                  bookingCode: booking.bookingCode,
                  numGuests: booking.numGuestsAfterUpdate,
                  timeSlot: booking.timeSlotAfterUpdate,
                  processedBy: userName,
                  bookingDate: booking.bookingDateAfterUpdate!.add(const Duration(hours: 12)),
                  status: BookingDTOStatusEnum.MODIFICA_CONFERMATA,
                ),
                true,
              );
            }
            Navigator.pop(context);
          },
          child: const Text('Accetta modifica'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            bool? reject = await _showConfirmationDialog(
              context,
              'Rifiuta le modifiche di ${booking.customer!.firstName!}?',
              'Si',
              'No',
            );

            if (reject == true) {
              final prefs = await SharedPreferences.getInstance();
              String? userName = await prefs.getString('username');
              restaurantManager.updateBooking(
                BookingDTO(
                  bookingCode: booking.bookingCode,
                  processedBy: userName,
                  status: BookingDTOStatusEnum.MODIFICA_RIFIUTATA,
                ),
                true,
              );
            }
            Navigator.pop(context);
          },
          child: const Text('Rifiuta modifica'),
        ),
      ]);
    }

    actions.add(
      CupertinoActionSheetAction(
        onPressed: () async {
          bool? delete = await _showConfirmationDialog(
            context,
            'Eliminare la prenotazione di ${booking.customer!.firstName!}?',
            'Si',
            'No',
          );

          if (delete == true) {
            bool? sendMessage = await _showConfirmationDialog(
              context,
              'Invia messaggio a ${booking.customer!.firstName!}?',
              'Si',
              'No',
            );
            final prefs = await SharedPreferences.getInstance();
            String? userName = await prefs.getString('username');

            restaurantManager.updateBooking(
              BookingDTO(
                bookingCode: booking.bookingCode,
                bookingId: booking.bookingId,
                processedBy: userName,
                status: BookingDTOStatusEnum.ELIMINATO,
              ),
              sendMessage == true,
            );
          }
          Navigator.pop(context);
        },
        child: const Text('Elimina'),
      ),
    );

    return actions;
  }

  Future<bool?> _showConfirmationDialog(
      BuildContext context,
      String message,
      String confirmText,
      String goBackText,
      ) async {
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