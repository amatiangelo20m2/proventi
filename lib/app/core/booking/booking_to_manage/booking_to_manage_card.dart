import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_edit.dart';
import 'package:proventi/app/core/whatsapp/whatsapp_chat.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:badges/badges.dart' as badges;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import '../../../../global/date_methods_utility.dart';

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
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildCardContent(BuildContext context) {
    return ListTile(
      trailing: Text(formatDuration(DateTime.now().difference(booking.createdAt!)), style: TextStyle(color: Colors.deepOrange),),
      title: Row(
        children: [
          Stack(
            children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileImage(
                customer: booking.customer!,
                branchCode: booking.branchCode!,
                avatarRadious: 30,
              ),
            ),
              Positioned(right: 0, child: getTimeRangeWidget(booking, restaurantDTO))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${booking.customer?.firstName!} ${booking.customer?.lastName!}',
                style: TextStyle(
                  fontSize: 14,
                  decoration: booking.status == BookingDTOStatusEnum.NON_ARRIVATO ? TextDecoration.lineThrough : TextDecoration.none,
                  color: Colors.blueGrey.shade900,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
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
                      Text(
                        ' 🕓${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
                        style: TextStyle(
                          fontSize: 15,

                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ],
                  ),

                  Text(getFormEmoji(formDTOs, booking)),
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
                  GestureDetector(onTap: () {

                    showCupertinoModalBottomSheet(
                      expand: true,
                      elevation: 10,
                      context: context,
                      builder: (BuildContext context) {
                        return DashChatCustomized20(bookingDTO: booking,);
                      },
                    );

                  }, child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),),
                ],
              ),
            ],
          ),
        ],
      ),
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
                  Text('Codice prenotazione:' + booking.bookingCode!, style: TextStyle(fontSize: 7),),
                  Text('Codice form:' + booking.formCode! + getFormEmoji(formDTOs, booking), style: TextStyle(fontSize: 7),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: getStatusColor(booking.status!),),
                      Text(booking.status!.value.replaceAll('_', '')),
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
              }, icon: Icon(CupertinoIcons.phone)),
            ),
          ],
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
                Response responseUpdate = await Provider.of<RestaurantStateManager>(context, listen: false)
                    .bookingControllerApi.updateBookingWithHttpInfo(BookingDTO(
                    bookingCode: booking.bookingCode,
                    status: BookingDTOStatusEnum.CONFERMATO
                ));
                if(responseUpdate.statusCode == 409){
                  Navigator.pop(context, null);
                  await Provider.of<RestaurantStateManager>(context, listen: false)
                      .refreshDate();
                  _showSnackbar(context, 'Prenotazione di ' + booking.customer!.firstName! + ' è già stata elaborata' );

                } else if(responseUpdate.statusCode == 200){
                  Navigator.pop(context, null);
                  await Provider.of<RestaurantStateManager>(context, listen: false)
                      .refreshDate();
                  _showSnackbar(context, 'Prenotazione di ' + booking.customer!.firstName! + ' confermata ✅' );
                }else{
                  _showSnackbar(context, 'Ho riscontrato un errore generico durante aggiormamento prenotazione di '+ booking.customer!.firstName!+ '. Riprova fra 2 minuti.❌❌' );

                }

            },
            child: const Text('Conferma prenotazione'),
          ),

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
          child: Icon(CupertinoIcons.moon_stars, color: CupertinoColors.white),
        ));
  }
}
