import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_edit/booking_customer_edit.dart';
import 'package:proventi/app/core/whatsapp/whatsapp_chat.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:badges/badges.dart' as badges;
import 'package:url_launcher/url_launcher.dart';

import '../../../../global/date_methods_utility.dart';
import '../../../../global/flag_picker.dart';
import '../../../../state_manager/communication_state_manager.dart';

class ProcessedBookingCard extends StatelessWidget {
  final BookingDTO booking;
  final List<FormDTO> formDTOs;

  const ProcessedBookingCard({required this.booking,
    required this.formDTOs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 1,
          child:  Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileImage(
                  allowNavigation: true,
                  customer: booking.customer!,
                  branchCode: booking.branchCode!,
                  avatarRadious: 30,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${booking.customer!.firstName!.toUpperCase()} ${booking.customer!.lastName!.toUpperCase()} ${getFlagByPrefix(booking.customer!.prefix!)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          Container(
                            width: 45,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Center(
                              child: Text(
                                '👥${booking.numGuests}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text('  🕖${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
                            style: TextStyle(color: Colors.grey[900]),),
                        ],
                      ),


                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(child: Column(
          children: [
            Text(getIconByStatus(booking.status!), style: const TextStyle(fontSize: 30)),
            Text(booking.status!.value.replaceAll('_', ' '), style: TextStyle(fontSize: 4),),
            Text(booking.bookingId.toString(), style: const TextStyle(fontSize: 7)),
          ],
        ), right: 0, top: -5,),]
      ),
    );
  }
}
