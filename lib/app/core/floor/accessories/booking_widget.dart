import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:intl/intl.dart';
import '../../../../api/restaurant_client/lib/api.dart';
import '../../../../global/style.dart';
import '../../../custom_widgets/profile_image_pro20/profile_image.dart';

class BookingWidget extends StatelessWidget {
  final BookingDTO booking;
  final bool isDragging;

  const BookingWidget({required this.booking, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Material(
          color: Colors.transparent,
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: blackDir),
            badgeContent: Text(
              booking.numGuests.toString(),
              style: const TextStyle(fontSize: 15, color: CupertinoColors.white),
            ),
            badgeAnimation: const badges.BadgeAnimation.rotation(),

            child: Column(
              children: [
                ProfileImage(
                    branchCode: booking.branchCode!,
                    avatarRadious: 30,
                    customer: booking.customer!,
                    allowNavigation: false),
                Text(booking.customer!.firstName!, style: const TextStyle(fontSize: 7),),
                Text(booking.customer!.lastName!, style: const TextStyle(fontSize: 5),),
                Text('🕖 ${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
                  style: TextStyle(fontSize: 6, color: Colors.grey[900], fontWeight: FontWeight.bold),),
              ],
            ),
          )),
    );
  }
}