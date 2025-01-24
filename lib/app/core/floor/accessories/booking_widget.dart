import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:intl/intl.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../../../api/restaurant_client/lib/api.dart';
import '../../../../global/style.dart';
import '../../../custom_widgets/profile_image_pro20/profile_image.dart';

class BookingWidget extends StatelessWidget {
  final BookingDTO booking;
  final bool isDragging;


  const BookingWidget({required this.booking, this.isDragging = false});


  @override
  Widget build(BuildContext context) {
    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider floorStateManager, Widget? child) {
        return GestureDetector(
          onTap: (){
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        booking.customer!.firstName!,
                        style: TextStyle(
                            fontSize: 20, color: blackDir),
                      ),
                    ],
                  ),

                  cancelButton:
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(
                          context); // Close the sheet
                    },
                    child: const Text('Annulla'),
                  ),
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      ProfileImage(
                          branchCode: booking.branchCode!,
                          avatarRadious: 30,
                          customer: booking.customer!,
                          allowNavigation: false,
                          borderSize: 3,
                          borderColor: getStatusColor(booking.status!)
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.circle, color: elegantRed,),
                            Text(
                              booking.numGuests!.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(booking.customer!.firstName!, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: !isDragging ? Colors.white : blackDir),),
                Text(booking.customer!.lastName!, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: !isDragging ? Colors.white : blackDir),),
                Text('🕖 ${booking.timeSlot!.bookingHour!}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes!)}',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: !isDragging ? Colors.white : blackDir),),
              ],
            ),
          ),
        );
      },
    );
  }
}