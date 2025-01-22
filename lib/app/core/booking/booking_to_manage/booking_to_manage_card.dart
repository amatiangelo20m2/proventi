import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_customer_edit.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import '../../../../global/date_methods_utility.dart';
import '../../../../global/flag_picker.dart';
import '../../../custom_widgets/whatsapp/chat_icon_whastapp.dart';
import '../bookings_utils.dart';

class BookingToManageCard extends StatelessWidget {
  final RestaurantDTO restaurantDTO;
  final BookingDTO booking;
  final List<FormDTO> formDTOs;

  const BookingToManageCard({required this.booking,
    required this.formDTOs, required this.restaurantDTO});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBookingActionMenuListaAttesta(context, booking);
      },
      child:  _buildCardContent(context),
    );
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

    final _controller = SuperTooltipController();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: ListTile(
              trailing:
              Text(
                formatDuration(DateTime.now().difference(booking.createdAt!)),
                style: TextStyle(color: Colors.grey[900], fontSize: 14, fontWeight: FontWeight.bold),
              ),
              title: Row(
                children: [
                  Stack(
                    children: [
                      Consumer<CustomerStateManager>(
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
                      Consumer<CustomerStateManager>(
                        builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {
                          if(customerStateManager.historicalCustomerData!.where((element) => element.customerDTO!.customerId == booking.customer!.customerId).isNotEmpty){
                            CustomerDTO customerHistory = customerStateManager.historicalCustomerData!.where((element)
                            => element.customerDTO!.customerId == booking.customer!.customerId).first.customerDTO!;
                            if(customerHistory.customerId! < 0){
                              return Positioned(
                                right: -10,
                                child: GestureDetector(
                                  onTap: () async {
                                    await _controller.showTooltip();
                                  },
                                  child: SuperTooltip(
                                    showBarrier: true,
                                    controller: _controller,

                                    content: Text(
                                      'Il cliente non si è presentato ${customerHistory.customerId!} volte',
                                      softWrap: true,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Lottie.asset('assets/lotties/danger.json', height: 50),
                                  ),
                                ),
                              );
                            }else{
                              return const Text('');
                            }
                          }else{
                            return const Text('');
                          }

                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${booking.customer?.firstName!} ${booking.customer?.lastName!} ${getFlagByPrefix(booking.customer!.prefix!)}',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: booking.status == BookingDTOStatusEnum.NON_ARRIVATO ? TextDecoration.lineThrough : TextDecoration.none,
                              color: elegantBlue,
                            ),
                          ),
                          Text(getFormEmoji(formDTOs, booking), style: TextStyle(fontSize: 13),),
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
                                  ? Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                      child: Text(
                                        currentBookingsOfTheCurrentCustomer.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 7),
                                      )))
                                  : const Icon(
                                Icons.fiber_new,
                                color: Colors.green,
                                size: 30,
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              buildComponentGuest(booking.numGuests.toString()),
                              Text(
                                ' 🕓${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
                                style: TextStyle(
                                  fontSize: 15,

                                  color: elegantBlue,
                                ),
                              ),
                            ],
                          ),

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
                                  branchCode: booking.branchCode!,);
                              },
                            );
                          }, icon: const Icon(CupertinoIcons.settings_solid)),
                          ChatIconWhatsApp(booking: booking, iconSize: 40),
                        ],
                      ),

                      if(booking.specialRequests?.isNotEmpty ?? false)
                        Text('💬${booking.specialRequests!}', style: const TextStyle(fontSize: 10),)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(right: 0, child: getTimeRangeWidget(booking, restaurantDTO))

      ],
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
                  Text('Data inserimento: ${DateFormat('dd-MM-yyyy HH:mm').format(booking.createdAt!)}', style: TextStyle(fontSize: 10),),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: getStatusColor(booking.status!),),
                      Text(booking.status!.value.replaceAll('_', ' ')),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,

              child: IconButton(onPressed: () async {


                Uri urlPhone = Uri(scheme: 'tel', path :booking.customer!.prefix! + booking.customer!.phone!);
                if (await canLaunchUrl(urlPhone)) {
                  await launchUrl(urlPhone);  // Open the phone dialer
                } else {
                  throw 'Could not open the phone dialer.';
                }
              }, icon: const Icon(CupertinoIcons.phone)),
            ),
          ],
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {


              bool confirmed = await _showConfirmationDialog(context,
                  'Conferma prenotazione di ${booking.customer!.firstName!}?' , '');

              if(confirmed){
                Response responseUpdate = await Provider.of<RestaurantStateManager>(context, listen: false)
                    .bookingControllerApi.updateBookingWithHttpInfo(true, BookingDTO(
                    bookingCode: booking.bookingCode,
                    status: BookingDTOStatusEnum.CONFERMATO
                ));
                if(responseUpdate.statusCode == 409){

                  await Provider.of<RestaurantStateManager>(context, listen: false)
                      .refreshDate();
                  _showSnackbar(context, 'Prenotazione di ${booking.customer!.firstName!} è già stata elaborata' );

                } else if(responseUpdate.statusCode == 200){
                  await Provider.of<RestaurantStateManager>(context, listen: false)
                      .refreshDate();
                  _showSnackbar(context, 'Prenotazione di ${booking.customer!.firstName!} confermata ✅' );
                }else{
                  _showSnackbar(context, 'Ho riscontrato un errore generico durante aggiormamento prenotazione di ${booking.customer!.firstName!}. Riprova fra 2 minuti.❌❌' );
                }
              }

              Navigator.pop(context, null);
            },
            child: const Text('Conferma prenotazione'),
          ),

          CupertinoActionSheetAction(
            onPressed: () async {
              bool confirmed = await _showConfirmationDialog(context, 'Rifiuta prenotazione di ${booking.customer!.firstName}?', '');
              if(confirmed){
                Provider.of<RestaurantStateManager>(context, listen: false)
                    .updateBooking(BookingDTO(
                    bookingCode: booking.bookingCode,
                    bookingId: booking.bookingId,
                    status: BookingDTOStatusEnum.RIFIUTATO
                ), true);
                Navigator.pop(context, null);
              }
            },
            child: const Text('Rifiuta prenotazione'),
          ),
          CupertinoActionSheetAction(

            onPressed: () async {

                bool confirmed = await _showConfirmationDialog(context, 'Elimina prenotazione di ${booking.customer!.firstName}?', '');
                if(confirmed) {
                  bool sendMessage = await _showConfirmationDialog(context, 'Invia messaggio di cancellazione a ${booking.customer!.firstName}?', '');

                  Provider.of<RestaurantStateManager>(context, listen: false)
                      .updateBooking(BookingDTO(
                      bookingCode: booking.bookingCode,
                      bookingId: booking.bookingId,
                      status: BookingDTOStatusEnum.ELIMINATO
                  ), sendMessage);
                  Navigator.pop(context, null);
                }
            },
            child: const Text('Elimina'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, null);
          },
          isDefaultAction: true,
          child: const Text('Indietro'),
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

  getTimeRangeWidget(BookingDTO booking, RestaurantDTO restaurantDTO) {
    return isLunchTime(booking, restaurantDTO) ? Card(
        color: globalGoldDark,
        child: const Padding(
          padding: EdgeInsets.all(2.0),
          child: Icon(Icons.sunny, color: CupertinoColors.white,),
        )) : Card(
        color: elegantBlue,
        child: const Padding(
          padding: EdgeInsets.all(2.0),
          child: Icon(CupertinoIcons.moon, color: CupertinoColors.white),
        ));
  }
}
