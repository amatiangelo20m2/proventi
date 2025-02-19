import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
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
    TextStyle headerStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle smallStyle = const TextStyle(fontSize: 15, color: Colors.black);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          '${widget.customerDTO.firstName!} ${widget.customerDTO.lastName!} ${getFlagByPrefix(widget.customerDTO.prefix!)}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
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
                    isAlsoBookingEditing: false,
                  );
                },
              );
            },
            icon: const Icon(CupertinoIcons.settings, size: 30),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    ProfileImage(
                      customer: widget.customerDTO,
                      branchCode: widget.branchCode,
                      avatarRadious: 70,
                      allowNavigation: false,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '📱+ ${widget.customerDTO.prefix!} ${widget.customerDTO.phone!}',
                      style: TextStyle(fontSize: 24, color: Colors.grey[600] , fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '✉️ ${widget.customerDTO.email!}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Booking History Section
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'Storico Prenotazioni',
                  style: headerStyle.copyWith(color: Colors.grey[600], fontSize: 14),
                ),
              ),

              // Filter by Booking Status
              Consumer<RestaurantStateManager>(
                builder: (context, restaurantManager, child) {
                  return FutureBuilder<List<BookingDTO>?>(
                    future: restaurantManager.bookingControllerApi.findBookingByCustomerPrefixAndPhone(
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
                            // Stats Row for Booking Statuses
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildBookingStatusCard(
                                    bookings.where((element) => element.status == BookingDTOStatusEnum.ARRIVATO).length,
                                    'Arrivato',
                                    Colors.green.withAlpha(180),
                                  ),
                                  _buildBookingStatusCard(
                                    bookings.where((element) => element.status == BookingDTOStatusEnum.NON_ARRIVATO).length,
                                    'No Show',
                                    Colors.yellow.shade700.withAlpha(180),
                                  ),
                                  _buildBookingStatusCard(
                                    bookings.where((element) => element.status == BookingDTOStatusEnum.RIFIUTATO).length,
                                    'Rifiutato',
                                    Colors.redAccent.withAlpha(180),
                                  ),
                                  _buildBookingStatusCard(
                                    bookings.where((element) => element.status == BookingDTOStatusEnum.ELIMINATO).length,
                                    'Eliminato',
                                    Colors.blueGrey.withAlpha(180),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),

                            // List of Bookings
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: bookings.length,
                              itemBuilder: (context, index) {
                                BookingDTO booking = bookings[index];
                                return _buildBookingTile(booking);
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
      ),
    );
  }

  Widget _buildBookingStatusCard(int count, String status, Color color) {
    return Card(
      color: color.withAlpha(200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              status,
              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '$count',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingTile(BookingDTO booking) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      title: Text(
        italianDateFormat.format(booking.bookingDate!),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
      ),
      subtitle: Text(
        'Ore: ${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      leading: Text(
        getIconByStatus(booking.status!),
        style: TextStyle(fontSize: 20),
      ),
      trailing: Card(
        color: blackDir.withAlpha(150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Text(
              booking.numGuests!.toString(),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      )
    );
  }
}