import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../../../custom_widgets/whatsapp/chat_icon_whastapp.dart';
import '../../notification/model/notification_entity.dart';
import '../../notification/state_manager/notification_state_manager.dart';
import '../booking_edit/booking_customer_edit.dart';
import '../bookings_utils.dart';

class FastQueueCard extends StatefulWidget {
  final BookingDTO booking;

  const FastQueueCard({super.key, required this.booking});

  @override
  State<FastQueueCard> createState() => _FastQueueCardState();
}

class _FastQueueCardState extends State<FastQueueCard> {

  Duration _timeElapsed = Duration.zero;
  DateTime _targetTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _targetTime  = widget.booking.createdAt!.add(
      Duration(minutes: widget.booking.timeWaitingFastQueueMinutes!),
    );
    _timeElapsed = _targetTime.difference(DateTime.now());
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: ListTile(
        onTap: (){
          _showSortMenu(context, widget.booking);
        },
        trailing: Consumer<NotificationStateManager>(
          builder: (BuildContext context, NotificationStateManager notificationManager, Widget? child) {
            return _buildWidgetByElapsedTime(notificationManager);
          },
        ),
        leading: ProfileImage(
            branchCode: widget.booking.branchCode!,
            avatarRadious: 20,
            customer: widget.booking.customer!,
            allowNavigation: true),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCustomerInfo(),

            Consumer<RestaurantStateManager>(
              builder: (BuildContext context, RestaurantStateManager value, Widget? child) {

                return IconButton(icon: Icon(CupertinoIcons.settings_solid, color: Colors.grey[900],), onPressed: (){
                  showCupertinoModalBottomSheet(
                    expand: true,
                    elevation: 10,
                    context: context,
                    builder: (BuildContext context) {
                      return BookingCustomerEdit(
                        bookingDTO: widget.booking,
                        restaurantDTO: value.restaurantConfiguration!,
                        isAlsoBookingEditing: true,
                        branchCode: widget.booking.branchCode!,);
                    },
                  );
                },);
              },),
            Consumer<NotificationStateManager>(
              builder: (BuildContext context, NotificationStateManager notificationManager, Widget? child) {
                return IconButton(onPressed: () async {

                  if(widget.booking.status == BookingDTOStatusEnum.LISTA_ATTESA){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Notifica cliente'),
                          content: const Text('Invia notifica a cliente?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {

                                try{
                                  Provider.of<RestaurantStateManager>(context, listen: false)
                                      .updateBooking(BookingDTO(
                                    bookingCode: widget.booking.bookingCode,
                                    status: BookingDTOStatusEnum.AVVISATO_LISTA_ATTESA,
                                  ), true);
                                  Fluttertoast.showToast(
                                    msg: "️Messaggio inviato a cliente️",
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: blackDir,
                                    timeInSecForIosWeb: 5,
                                    fontSize: 18.0,
                                  );
                                }catch(e){
                                  Fluttertoast.showToast(
                                    msg: "️Errore durante invio messaggio. Errore: $e️",
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.redAccent,
                                    timeInSecForIosWeb: 5,
                                    fontSize: 18.0,
                                  );
                                }
                                Navigator.of(context).pop();
                              },
                              child: const Text('Si'),
                            ),
                          ],
                        );
                      },
                    );
                  }else{
                    Fluttertoast.showToast(
                        msg: "️Messaggio già inviato a cliente️",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2);
                  }


                }, icon: Icon(CupertinoIcons.paperplane, color: widget.booking.status == BookingDTOStatusEnum.AVVISATO_LISTA_ATTESA ? Colors.blueAccent : Colors.grey,));
              },
            ),
          if(widget.booking.status == BookingDTOStatusEnum.AVVISATO_LISTA_ATTESA)
            ChatIconWhatsApp(
                booking: widget.booking
            ),
          ],
        ),
      ),
    );
  }

  Column _buildCustomerInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.booking.customer?.firstName!} ${widget.booking.customer?.lastName}',
          style: TextStyle(
            fontSize: 13,
            color: elegantBlue,
          ),
        ),
        Row(
          children: [
            buildComponentGuest(widget.booking.numGuests.toString()),
            _buildTimeBooking(context),
          ],
        )

      ],
    );
  }

  Row _buildTimeBooking(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(CupertinoIcons.clock, color: Colors.blueGrey,),
        Text(
          ' ${NumberFormat("00").format(widget.booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(widget.booking.timeSlot?.bookingMinutes)}',
          style: TextStyle(
            fontSize: 13,
            color: elegantBlue,
          ),
        ),
      ],
    );
  }

  void _showSortMenu(BuildContext context, BookingDTO booking) {
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
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(onPressed: () {

              }, icon: const Icon(CupertinoIcons.phone)),
            ),
          ],
        ),
        actions: [

          CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(BookingDTO(
                bookingCode: booking.bookingCode,
                status: BookingDTOStatusEnum.ARRIVATO,
              ), true);
              Navigator.pop(context, null);

            },
            child: const Text('Segna come arrivato'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              booking.status = BookingDTOStatusEnum.NON_ARRIVATO;
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(booking, true);
              Navigator.pop(context, null);

            },
            child: const Text('Non arrivato'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {



              booking.status = BookingDTOStatusEnum.ELIMINATO;
              Provider.of<RestaurantStateManager>(context, listen: false)
                  .updateBooking(booking, true);
              Navigator.pop(context, null);
            },
            child: const Text('Cancella'),
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

  Widget _buildWidgetByElapsedTime(NotificationStateManager notificationManager) {
    return TimerCountdown(
      enableDescriptions: false,
      spacerWidth: 2,
      timeTextStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: elegantBlue,
      ),
      format: CountDownTimerFormat.minutesSeconds,
      endTime: DateTime.now().add(
          _timeElapsed
      ),
      onEnd: () {
        if(!_timeElapsed.isNegative){
          notificationManager.addNotification(
            NotificationModel(
              title: 'Tempo di attesa per ${widget.booking.customer!.firstName!} ${widget.booking.customer!.lastName!} terminato!!',
              body: 'Manda il messaggio di invito',
              dateReceived: DateTime.now().toLocal().toString(),
              read: '0',
              bookingId: widget.booking.bookingCode!,
              navigationPage: 'QUEUE_FAST',
            ),
          );
        }
      },
    );
  }

}
