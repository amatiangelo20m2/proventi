import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';
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

    return Consumer<CustomerStateManager>(
      builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {
        CustomerHistory customerHistory = customerStateManager.currentCustomersList!
            .where((element) => element.customerId == widget.customerDTO.customerId)
            .first;

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
                  padding: const EdgeInsets.all(1.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'ARRIVATO ${getIconByStatus(BookingDTOStatusEnum.ARRIVATO)}',
                            style: globalStyle,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'NO SHOW ${getIconByStatus(BookingDTOStatusEnum.NON_ARRIVATO)}',
                            style: globalStyle,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'RIFIUTATO ${getIconByStatus(BookingDTOStatusEnum.RIFIUTATO)}',
                            style: globalStyle,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ELIMINATO ${getIconByStatus(BookingDTOStatusEnum.ELIMINATO)}',
                            style: globalStyle,
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text('${customerHistory.arrivatoCount ?? 0}', style: globalStyle)),
                            DataCell(
                              Text(
                                '${customerHistory.nonArrivatoCount ?? 0}',
                                style: globalStyle.copyWith(
                                  color: customerHistory.nonArrivatoCount! > 0
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                            DataCell(Text('${customerHistory.rifiutatoCount ?? 0}', style: globalStyle)),
                            DataCell(Text('${customerHistory.eliminatoCount ?? 0}', style: globalStyle)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'STORICO PRENOTAZIONI',
                    style: headerStyle.copyWith(color: globalGoldDark),
                  ),
                ),
                Consumer<RestaurantStateManager>(
                  builder: (context, restaurantManager, child) {
                    return FutureBuilder<List<BookingDTO>?>(
                      future: restaurantManager.bookingControllerApi.findBookingByCustomerPrefixAndPhone(
                        widget.customerDTO.prefix!,
                        widget.customerDTO.phone!,
                        widget.branchCode!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No bookings found.'));
                        } else {
                          List<BookingDTO> bookings = snapshot.data!
                              .where((element) => filteredStatus.contains(element.status))
                              .toList();

                          return ListView.builder(
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
                                    'id: ${booking.bookingId}',
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
      },
    );
  }
}
