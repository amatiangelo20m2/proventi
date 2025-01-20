import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:proventi/app/custom_widgets/profile_image_pro20/profile_image.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../api/restaurant_client/lib/api.dart';
import 'accessories/floor_drawer.dart';
import 'accessories/grid_painter.dart';

class Floor extends StatefulWidget {
  const Floor({super.key, required this.bookingsIncoming});

  final List<BookingDTO> bookingsIncoming;

  @override
  State<Floor> createState() => _FloorState();
}

class _FloorState extends State<Floor> {

  List<TableConf> tables = [];
  List<BookingDTO> bookings = [];

  double tableSize = 80.0;

  Size getTableSize(int partySize) {
    if (partySize <= 4) {
      return const Size(70, 70);
    } else if (partySize <= 7) {
      return const Size(100, 70);
    } else if (partySize <= 12) {
      return const Size(140, 70);
    } else if (partySize <= 16) {
      return const Size(180, 70);
    } else {
      return const Size(220, 70);
    }
  }

  @override
  void initState() {
    super.initState();

    bookings = widget.bookingsIncoming;
  }

  void addTable() async {
    int selectedSize = 2;

    int? partySize = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Aggiungi tavolo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Crea nuovo tavolo'),
                  DropdownButton<int>(
                    value: selectedSize,
                    items: List.generate(18, (index) => index + 1)
                        .map((size) => DropdownMenuItem<int>(
                      value: size,
                      child: Text('Tavolo per $size'),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSize = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Cancel
                  child: const Text('Chiudi'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, selectedSize), // Confirm
                  child: const Text('Aggiungi'),
                ),
              ],
            );
          },
        );
      },
    );

    if (partySize != null) {
      setState(() {
        tables.add(TableConf(
          code: Uuid().v4(),
          name: 'Tavolo ${tables.length + 1}',
          partyNumber: partySize,
          orientation: TableConfOrientationEnum.VERTICAL,
          offsetX: 100,
          offsetY: 100,


        ));
      });
    }
  }
  void assignBookingToTable(String tableCode, String bookingCode) {
    setState(() {
      final table = tables.firstWhere((t) => t.code == tableCode);
      table.code = bookingCode;

      // Remove the booking from the available list
      bookings.removeWhere((b) => b.bookingCode == bookingCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider floorStateManager, Widget? child) {
        return Scaffold(
          drawer: FloorDrawer(),
          appBar: AppBar(
            title: Text(floorStateManager.currentFloor.floorName!),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey.shade700,
                height: 1.0,
              ),
            ),
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.add, size: 30,),
                onPressed: addTable,
              ),
              IconButton(
                icon: const Icon(Icons.clear, size: 30,),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          body: Stack(
            children: [

              CustomPaint(
                size: screenSize,
                painter: GridPainter(gridSize: 15),
              ),
              Container(
                color: Colors.transparent,
                child: Stack(
                  children: tables.map((table) {
                    return Positioned(
                        left: table.offsetX,
                        top: table.offsetY,
                        child: Draggable<TableConf>(
                          data: table,
                          feedback: TableWidget(
                            table: table,
                            isDragging: true,
                            onToggleOrientation:
                                () {}, // No toggling while dragging
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.2,
                            child: TableWidget(
                              table: table,
                              onToggleOrientation: () {},
                            ),
                          ),
                          onDragEnd: (details) {
                            setState(() {
                              double maxX = screenSize.width - tableSize;
                              double maxY = screenSize.height -
                                  tableSize -
                                  kToolbarHeight -
                                  MediaQuery.of(context).padding.top;

                              double newX = (details.offset.dx - tableSize / 2)
                                  .clamp(0.0, maxX);
                              double newY = (details.offset.dy - tableSize / 2)
                                  .clamp(0.0, maxY);

                              table.offsetX =newX;
                              table.offsetY = newY;
                            });
                          },
                          child: DragTarget<String>(
                            onAccept: (bookingCode){
                                  //assignBookingToTable(table.id, bookingId),
                            },
                            builder: (context, candidateData, rejectedData) {
                              return TableWidget(
                                table: table,
                                highlight: candidateData.isNotEmpty,
                                onToggleOrientation: () {
                                  setState(() {
                                    table.orientation = table.orientation ==
                                        TableConfOrientationEnum.VERTICAL
                                        ? TableConfOrientationEnum.HORIZONTAL
                                        : TableConfOrientationEnum.VERTICAL;
                                  });
                                },
                              );
                            },
                          ),
                        )
                    );
                  }).toList(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 100,
                  color: Colors.transparent,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return Draggable<String>(
                        data: booking.bookingCode,
                        feedback: BookingWidget(booking: booking, isDragging: true),
                        child: BookingWidget(booking: booking),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class TableWidget extends StatefulWidget {
  final TableConf table;
  final bool isDragging;
  final bool highlight;
  final VoidCallback onToggleOrientation;

  const TableWidget({
    required this.table,
    this.isDragging = false,
    this.highlight = false,
    required this.onToggleOrientation,
  });

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    Size tableSize = _FloorState().getTableSize(widget.table.partyNumber!);

    return GestureDetector(
      onDoubleTap: widget.onToggleOrientation,
      onTap: () {
        if (widget.table.code != null) {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                title: const Text(
                  'Gestione Tavolo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                message: Text(
                  'Vuoi rimuovere la prenotazione dal tavolo "${widget.table.name}"?',
                  style: const TextStyle(fontSize: 16),
                ),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context); // Close the sheet

                      // Update local state
                      setState(() {
                        widget.table.code = null;
                      });
                    },
                    child: const Text(
                      'Rimuovi Prenotazione',
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
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.grey.shade800),
              badgeContent: Text(
                widget.table.partyNumber.toString(),
                style: const TextStyle(fontSize: 15, color: CupertinoColors.white),
              ),
              badgeAnimation: const badges.BadgeAnimation.slide(),
              child: Container(
                width: widget.table.orientation == TableConfOrientationEnum.VERTICAL
                    ? tableSize.width
                    : tableSize.height,
                height: widget.table.orientation == TableConfOrientationEnum.VERTICAL
                    ? tableSize.height
                    : tableSize.width,
                decoration: BoxDecoration(
                  color: widget.highlight ? Colors.black.withOpacity(0.5) : Colors.black,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.table.code != null
                        ? '${widget.table.name}\n(${widget.table.offsetX.toString()}, ${widget.table.offsetY.toString()})'
                        : '+',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
            Text(
              widget.table.name!,
              style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}



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
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.grey.shade800),
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




