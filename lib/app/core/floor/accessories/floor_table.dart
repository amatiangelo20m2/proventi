import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:proventi/app/custom_widgets/whatsapp/chat_icon_whastapp.dart';
import 'package:provider/provider.dart';
import '../../../../api/restaurant_client/lib/api.dart';
import '../../../../global/style.dart';
import '../../../../state_manager/restaurant_state_manager.dart';
import '../state_manager/floor_state_manager.dart';
import 'package:badges/badges.dart' as badges;

import 'floor_design.dart';

class FloorTable extends StatefulWidget {
  final TableConfDTO table;
  final bool isDragging;
  final bool highlight;
  final VoidCallback onToggleOrientation;
  final List<BookingDTO> bookings;
  final DateTime currentSelectedDate;

  const FloorTable({
    super.key,
    required this.table,
    this.isDragging = false,
    this.highlight = false,
    required this.onToggleOrientation,
    required this.bookings,
    required this.currentSelectedDate,
  });

  @override
  State<FloorTable> createState() => _FloorTableState();
}

class _FloorTableState extends State<FloorTable> {
  @override
  Widget build(BuildContext context) {
    Size tableSize = getTableSize(widget.table.partyNumber!);

    // Match bookings with the table's calendar configuration
    List<BookingDTO> matchedBookings = widget.table.tableBookingCalendarConf
        .map((conf) => widget.bookings.firstWhere(
          (booking) => booking.bookingCode == conf.bookingCode,
      orElse: () => BookingDTO(
        numGuests: 0,
        customer: CustomerDTO(
          firstName: 'N/A',
          lastName: 'N/A',
        ),
      ),
    ))
        .toList();

    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider floorStateManager,
          Widget? child) {
        return GestureDetector(
          onDoubleTap: widget.onToggleOrientation,
          onTap: () {
            if (widget.table.tableCode != null) {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: Text(
                      'Gestione ${widget.table.tableName!}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800),
                    ),
                    actions: [
                      ...matchedBookings.map((booking) {
                        return
                          Material(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      ProfileImage(
                                        branchCode: booking.branchCode!,
                                        avatarRadious: 30,
                                        customer: booking.customer!,
                                        allowNavigation: false,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              '${booking.customer!.firstName!} ${booking.customer!.firstName!}',
                                              style: TextStyle(
                                                  color: blackDir, fontSize: 15),
                                            ),
                                            Text(
                                              '${booking.numGuests} persone alle ${booking.timeSlot != null ? '${NumberFormat("00").format(booking.timeSlot!.bookingHour)}:${NumberFormat("00").format(booking.timeSlot!.bookingMinutes)}' : '🕓N/A'}',
                                              style: TextStyle(
                                                  color: blackDir, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(onPressed: (){
                                    Navigator.pop(context); // Close the sheet

                                    // Remove reservation from table
                                    Provider.of<FloorStateManagerProvider>(context,
                                        listen: false)
                                        .removeReservationFromTable(
                                        widget.table.tableCode!, booking.bookingCode!);
                                  }, icon: Icon(CupertinoIcons.delete))
                                ],
                              ),
                            ),
                          );
                      }).toList(),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Conferma Eliminazione'),
                                content: const Text('Sei sicuro di eliminare il tavolo?'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: const Text('Annulla'),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      floorStateManager.deleteTable(widget.table.tableCode!);
                                      Navigator.of(context).pop(); // Close the dialog
                                      Navigator.pop(context); // Close the sheet
                                    },
                                    child: const Text('Elimina'),
                                    isDestructiveAction: true,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Elimina Tavolo',
                          style: TextStyle(color: CupertinoColors.systemRed),
                        ),
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context); // Close the sheet
                      },
                      child: const Text('Annulla'),
                    ),
                  );
                },
              );
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                      badgeColor: matchedBookings.isNotEmpty
                          ? globalGoldDark
                          : elegantGreen),
                  badgeContent: Text(
                    matchedBookings.isNotEmpty
                        ? matchedBookings.first.numGuests.toString()
                        : widget.table.partyNumber.toString(),
                    style: const TextStyle(
                        fontSize: 15, color: CupertinoColors.white),
                  ),
                  badgeAnimation: const badges.BadgeAnimation.slide(),
                  child: Card(
                    color: matchedBookings.isNotEmpty
                        ? blackDir
                        : Colors.white,
                    elevation: 9,
                    child: Container(
                      width: widget.table.orientation ==
                          TableConfDTOOrientationEnum.VERTICAL
                          ? tableSize.width
                          : tableSize.height,
                      height: widget.table.orientation ==
                          TableConfDTOOrientationEnum.VERTICAL
                          ? tableSize.height
                          : tableSize.width,
                      decoration: BoxDecoration(
                        color: widget.highlight
                            ? globalGoldDark.withOpacity(0.5)
                            : Colors.transparent,
                        border: Border.all(
                            color: Colors.grey.shade600, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Builder(
                        builder: (BuildContext context) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                matchedBookings.isNotEmpty
                                    ? Column(
                                  children: [
                                    Text(
                                      '${matchedBookings.first.customer!.firstName!} ${matchedBookings.first.customer!.lastName!}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      matchedBookings.first.timeSlot != null
                                          ? '${NumberFormat("00").format(matchedBookings.first.timeSlot!.bookingHour)}:${NumberFormat("00").format(matchedBookings.first.timeSlot!.bookingMinutes)}'
                                          : '🕓N/A',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                    : IconButton(
                                  onPressed: () {
                                    // Get the filtered and sorted bookings
                                    final filteredBookings =
                                    sortBookingsByMatch(
                                      floorStateManager.getFilteredBookings(
                                          widget.bookings),
                                      widget.table.partyNumber!,
                                    );

                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoActionSheet(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.table.tableName!,
                                                style: TextStyle(
                                                    fontSize: 20, color: blackDir),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    ' ${widget.table.partyNumber!}',
                                                    style:
                                                    TextStyle(
                                                      fontSize: 20,
                                                      color:
                                                      blackDir,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 4),
                                                    child: Icon(Icons.table_restaurant,
                                                        color: blackDir),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          actions: filteredBookings.map((booking) {
                                            return CupertinoActionSheetAction(
                                              onPressed: () {

                                                Navigator.pop(context); // Close the sheet
                                                floorStateManager.assignBookingToTable(
                                                  widget.table.tableCode!,
                                                  booking.bookingCode!,
                                                  widget.currentSelectedDate,
                                                  widget.bookings
                                                );
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Row(
                                                    children: [
                                                      ProfileImage(
                                                        branchCode: booking.branchCode!,
                                                        avatarRadious: 30,
                                                        customer: booking.customer!,
                                                        allowNavigation: false,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              '${booking.customer!.firstName} ${booking.customer!.lastName}',
                                                              style: const TextStyle(fontSize: 10),
                                                            ),
                                                            Text(
                                                              ' 🕓${NumberFormat("00").format(booking.timeSlot?.bookingHour)}:${NumberFormat("00").format(booking.timeSlot?.bookingMinutes)}',
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color: elegantBlue,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Card(
                                                        color: getMatchingColor(
                                                          widget.table.partyNumber!,
                                                          booking.numGuests!,
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(30),
                                                        ),
                                                        elevation: 10,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                '  ${booking.numGuests} ',
                                                                style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              const Icon(Icons.person, color: Colors.white),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
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
                                  icon: Icon(Icons.add, color: blackDir),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.table.tableName!,
                  style: const TextStyle(
                      fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<BookingDTO> sortBookingsByMatch(List<BookingDTO> bookings, int partyNumber) {
    return bookings
      ..sort((a, b) {
        int distanceA = (a.numGuests! - partyNumber).abs();
        int distanceB = (b.numGuests! - partyNumber).abs();
        return distanceA.compareTo(distanceB);
      });
  }

}
