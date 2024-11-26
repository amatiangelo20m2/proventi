import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:provider/provider.dart';

import '../../../global/flag_picker.dart';

class SingleCustomerHistory extends StatefulWidget {
  const SingleCustomerHistory({super.key, required this.customerHistory});



  final CustomerHistory customerHistory;

  @override
  State<SingleCustomerHistory> createState() => _SingleCustomerHistoryState();
}

class _SingleCustomerHistoryState extends State<SingleCustomerHistory> {

  TextStyle globalStyle = TextStyle(fontSize: 18);

  TextStyle testStyle = TextStyle(
    fontSize: 17,
    color: Colors.black, // Default color for text
  );

  List<BookingDTOStatusEnum> filteredStatus = [
    BookingDTOStatusEnum.ARRIVATO,
    BookingDTOStatusEnum.NON_ARRIVATO,
    BookingDTOStatusEnum.RIFIUTATO,
    BookingDTOStatusEnum.ELIMINATO];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileImage(prefix: widget.customerHistory.prefix!,
                    phone: widget.customerHistory.phone!,
                    branchCode: widget.customerHistory.branchCode!,
                    avatarRadious: 100,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.customerHistory.firstName!} ${widget.customerHistory.lastName!} ${getFlagByPrefix(widget.customerHistory.prefix!)}', style: globalStyle.copyWith(fontSize: 25),),
                    Text('📱(${widget.customerHistory.prefix!}) ${widget.customerHistory.phone!}', style: globalStyle,),
                    Text('✉️${widget.customerHistory.email!}', style: globalStyle,),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ARRIVATO ${getIconByStatus(BookingDTOStatusEnum.ARRIVATO)}', style: testStyle)),
                  DataColumn(label: Text('NO SHOW ${getIconByStatus(BookingDTOStatusEnum.NON_ARRIVATO)}', style: testStyle)),
                  DataColumn(label: Text('RIFIUTATO ${getIconByStatus(BookingDTOStatusEnum.RIFIUTATO)}', style: testStyle)),
                  DataColumn(label: Text('ELIMINATO ${getIconByStatus(BookingDTOStatusEnum.ELIMINATO)}', style: testStyle)),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('${widget.customerHistory.arrivatoCount ?? 0}', style: testStyle)),
                      DataCell(Text('${widget.customerHistory.nonArrivatoCount ?? 0}',
                        style: testStyle.copyWith(
                          color: widget.customerHistory.nonArrivatoCount! > 0 ? Colors.red : Colors.black,
                        ),
                      )),
                      DataCell(Text('${widget.customerHistory.rifiutatoCount ?? 0}', style: testStyle)),
                      DataCell(Text('${widget.customerHistory.eliminatoCount ?? 0}', style: testStyle)),
                    ],
                  ),
                ],
              ),
            ),
            Text('STORICO PRENOTAZIONI'),
            SizedBox(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width - 20,
              child: Card(
                surfaceTintColor: CupertinoColors.white,
                color: CupertinoColors.white,
                shadowColor: Colors.black,
                child: Consumer<RestaurantStateManager>(
                  builder: (BuildContext context, RestaurantStateManager restaurantManager, Widget? child) {
                    return FutureBuilder<List<BookingDTO>?>(
                      future: restaurantManager
                          .bookingControllerApi
                          .findBookingByCustomerPrefixAndPhone(widget.customerHistory.prefix!,
                          widget.customerHistory.phone!, widget.customerHistory.branchCode!),
                      builder: (BuildContext context, AsyncSnapshot<List<BookingDTO>?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator()); // Show loading spinner while waiting
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}')); // Show error message if API fails
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No bookings found.'));
                        } else {
                          List<BookingDTO> bookings = snapshot.data!.where((element) => filteredStatus.contains(element.status)).toList();

                          // Display the list of bookings
                          return ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              BookingDTO booking = bookings[index];
                              return ListTile(
                                title: Text(italianDateFormat.format(booking.bookingDate!)),
                                subtitle: Text('Booking ID: ${booking.bookingId}', style: TextStyle(fontSize: 10),),
                                trailing: Text(getIconByStatus(booking.status!), style: testStyle,),
                                leading: Card(color: globalGoldDark, child: Padding(
                                  padding: const EdgeInsets.only(right: 8, left: 8),
                                  child: Text(booking.numGuests!.toString(), style: testStyle.copyWith(color: CupertinoColors.white),),
                                )),
                                onTap: () {
                                  // Add action on tap if needed (e.g., show booking details)
                                },
                              );
                            },
                          );
                        }
                      },
                    );
                  },

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
