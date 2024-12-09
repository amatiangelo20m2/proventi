import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:provider/provider.dart';
import '../../../global/flag_picker.dart';
import '../booking/booking_edit/booking_customer_edit.dart';

class SingleCustomerHistory extends StatefulWidget {
  const SingleCustomerHistory({super.key, required this.customerDTO, required this.branchCode});

  final CustomerDTO customerDTO;
  final String branchCode;


  @override
  State<SingleCustomerHistory> createState() => _SingleCustomerHistoryState();
}

class _SingleCustomerHistoryState extends State<SingleCustomerHistory> {
  List<BookingDTOStatusEnum> filteredStatus = [
    BookingDTOStatusEnum.ARRIVATO,
    BookingDTOStatusEnum.NON_ARRIVATO,
    BookingDTOStatusEnum.RIFIUTATO,
    BookingDTOStatusEnum.ELIMINATO
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    TextStyle globalStyle = const TextStyle(fontSize: 15);
    TextStyle headerStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle smallStyle = const TextStyle(fontSize: 15, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            showCupertinoModalBottomSheet(
              expand: true,
              elevation: 10,
              context: context,
              builder: (BuildContext context) {
                return BookingCustomerEdit(
                  branchCode: widget.branchCode,
                  bookingDTO: BookingDTO(
                    customer: widget.customerDTO,
                  ),
                  restaurantDTO: RestaurantDTO(),
                  isAlsoBookingEditing: false,);
              },
            );
          }, icon: const Icon(CupertinoIcons.settings))
        ],
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.customerDTO.firstName!} ${widget.customerDTO.lastName!}'
              ' ${getFlagByPrefix(widget.customerDTO.prefix!)}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    ProfileImage(
                      customer: widget.customerDTO,
                      branchCode: widget.branchCode,
                      avatarRadious: 100, allowNavigation: false,

                    ),
                    Text(
                      '📱 (${widget.customerDTO.prefix!}) ${widget.customerDTO.phone!}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[900],
                      ),
                    ),
                    Text(
                      '✉️ ${widget.customerDTO.email!}',
                      style: TextStyle(
                        fontSize: screenHeight / 50,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'STORICO PRENOTAZIONI',
                  style: headerStyle.copyWith(color: Colors.grey[900]),
                ),
              ),
            ),
            Consumer<RestaurantStateManager>(
              builder: (context, restaurantManager, child) {
                return FutureBuilder<List<BookingDTO>?>(
                  future: restaurantManager
                      .bookingControllerApi
                      .findBookingByCustomerPrefixAndPhone(
                    widget.customerDTO.prefix!,
                    widget.customerDTO.phone!,
                    widget.branchCode,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Nessuna prenotazione trovata'));
                    } else {
                      List<BookingDTO> bookings = snapshot.data!
                          .where((element) => filteredStatus.contains(element.status))
                          .toList();

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Card(
                                surfaceTintColor: Colors.grey[900],
                                color: Colors.grey[900],
                                child: DataTable(

                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'ARRIVATO ${getIconByStatus(BookingDTOStatusEnum.ARRIVATO)}',
                                        style: globalStyle.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'NO SHOW ${getIconByStatus(BookingDTOStatusEnum.NON_ARRIVATO)}',
                                        style: globalStyle.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'RIFIUTATO ${getIconByStatus(BookingDTOStatusEnum.RIFIUTATO)}',
                                        style: globalStyle.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'ELIMINATO ${getIconByStatus(BookingDTOStatusEnum.ELIMINATO)}',
                                        style: globalStyle.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(Center(child: Text('${bookings.where((element) => element.status == BookingDTOStatusEnum.ARRIVATO).length}', style: globalStyle.copyWith(color: Colors.white),))),
                                        DataCell(Center(child: Text('${bookings.where((element) => element.status == BookingDTOStatusEnum.NON_ARRIVATO).length}', style: globalStyle.copyWith(color: Colors.white),)),),
                                        DataCell(Center(child: Text('${bookings.where((element) => element.status == BookingDTOStatusEnum.RIFIUTATO).length}', style: globalStyle.copyWith(color: Colors.white),))),
                                        DataCell(Center(child: Text('${bookings.where((element) => element.status == BookingDTOStatusEnum.ELIMINATO).length}', style: globalStyle.copyWith(color: Colors.white),))),
                                      ],

                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              BookingDTO booking = bookings[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                    italianDateFormat.format(booking.bookingDate!),
                                    style: globalStyle,
                                  ),
                                  subtitle: Text(
                                    'Ore: ${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
                                    style: smallStyle.copyWith(fontSize: 10),
                                  ),
                                  trailing: Text(
                                    getIconByStatus(booking.status!),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    child: Text(
                                      booking.numGuests!.toString(),
                                      style: globalStyle.copyWith(color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
