import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:provider/provider.dart';

import '../../../global/flag_picker.dart';

class SingleCustomerHistory extends StatefulWidget {
  const SingleCustomerHistory({super.key, required this.customerDTO, required this.branchCode, });

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
    double screenWidth = MediaQuery.of(context).size.width;

    TextStyle globalStyle = TextStyle(fontSize: 15);
    TextStyle headerStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    TextStyle smallStyle = TextStyle(fontSize: 15, color: Colors.black);

    return Consumer<CustomerStateManager>(
      builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {

        CustomerHistory customerHistory = customerStateManager.currentCustomersList!.where((element) => element.customerId == widget.customerDTO.customerId).first;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: screenHeight -160,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: globalGoldDark,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: widget.customerDTO.prefix! + widget.customerDTO.phone!,
                          child: ProfileImage(
                            customer: widget.customerDTO,
                            branchCode: widget.branchCode,
                            avatarRadious: screenWidth / 6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.customerDTO.firstName!} ${widget.customerDTO.lastName!} ${getFlagByPrefix(widget.customerDTO.prefix!)}',
                          style: TextStyle(
                            fontSize: screenHeight / 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '📱 (${widget.customerDTO.prefix!}) ${widget.customerDTO.phone!}',
                          style: TextStyle(
                            fontSize: screenHeight / 50,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '✉️ ${widget.customerDTO.email!}',
                          style: TextStyle(
                            fontSize: screenHeight / 50,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                                physics: NeverScrollableScrollPhysics(),
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
                                        'Booking ID: ${booking.bookingId}',
                                        style: smallStyle,
                                      ),
                                      trailing: Text(
                                        getIconByStatus(booking.status!),
                                        style: globalStyle,
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: globalGoldDark,
                                        child: Text(
                                          booking.numGuests!.toString(),
                                          style: globalStyle.copyWith(color: Colors.white),
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
            ],
          ),
        );
      },
    );
  }
}
