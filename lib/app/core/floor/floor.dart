import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:badges/badges.dart' as badges;
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:uuid/uuid.dart';
import '../../../api/restaurant_client/lib/api.dart';
import 'accessories/booking_widget.dart';
import 'accessories/floor_drawer.dart';
import 'accessories/grid_painter.dart';
import 'accessories/size.dart';

class Floor extends StatefulWidget {
  const Floor(
      {super.key,
      required this.bookingsIncoming,
      required this.currentSelectedDate});

  final List<BookingDTO> bookingsIncoming;
  final DateTime currentSelectedDate;

  @override
  State<Floor> createState() => _FloorState();
}

class _FloorState extends State<Floor> {
  List<BookingDTO> bookings = [];
  double tableSize = 80.0;

  @override
  void initState() {
    super.initState();
    bookings = widget.bookingsIncoming;
  }

  void addTable(FloorStateManagerProvider floorStateManager) async {
    final TextEditingController nameController = TextEditingController();
    int selectedSize = 2;
    int? partySize = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Crea nuovo tavolo',
                  style: TextStyle(fontSize: 18)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoTextField(
                      clearButtonMode: OverlayVisibilityMode.always,
                      controller: nameController,
                      placeholder: 'Nome del tavolo',
                    ),
                    DropdownButton<int>(
                      value: selectedSize,
                      items: List.generate(18, (index) => index + 1)
                          .map((size) => DropdownMenuItem<int>(
                                value: size,
                                child: Text('Tavolo per $size',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
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
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Cancel
                  child: const Text('Chiudi'),
                ),
                TextButton(
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text('Errore'),
                            content: const Text(
                                'Il nome del tavolo è obbligatorio.'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (floorStateManager.currentFloor.tables.any((t) =>
                        t.tableName!.toLowerCase() ==
                        nameController.text.toLowerCase())) {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text('Errore'),
                            content: const Text(
                                'Esiste già un tavolo con questo nome.'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.pop(context, selectedSize); // Confirm
                    }
                  },
                  child: const Text('Aggiungi'),
                ),
              ],
            );
          },
        );
      },
    );

    if (partySize != null) {
      floorStateManager.addNewTable(TableConfDTO(
        tableCode: Uuid().v4(),
        tableName: nameController.text,
        partyNumber: partySize,
        orientation: TableConfDTOOrientationEnum.VERTICAL,
        offsetX: 50,
        offsetY: 50,
      ));
    }
  }

  void assignBookingToTable(FloorStateManagerProvider floorStateManager,
      String tableCode, String bookingCode) {
    setState(() {
      floorStateManager.assignBookingToTable(tableCode, bookingCode);
    });
  }

  final _controller = SuperTooltipController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context,
          FloorStateManagerProvider floorStateManager, Widget? child) {
        final filteredBookings =
            floorStateManager.getFilteredBookings(bookings);

        return Scaffold(
          drawer: FloorDrawer(),
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  floorStateManager.currentFloor.floorName!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900),
                ),
                Text(
                  floorStateManager.currentFloor.floorDescription!,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: blackDir,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                ),
                height: 5.0,
              ),
            ),
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () async {
                    if (floorStateManager.isEdited) {
                      await floorStateManager.saveCurrentConfiguration();
                      Fluttertoast.showToast(
                        msg: "Configurazione salvata",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: blackDir,
                        timeInSecForIosWeb: 2,
                        fontSize: 14.0,
                      );
                    } else {
                      await floorStateManager.saveCurrentConfiguration();
                      Fluttertoast.showToast(
                        msg: "Nessuna modifica da salvare",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.grey,
                        timeInSecForIosWeb: 2,
                        fontSize: 14.0,
                      );
                    }
                  },
                  icon: Icon(
                    floorStateManager.isEdited
                        ? CupertinoIcons.square_arrow_down_fill
                        : CupertinoIcons.square_arrow_down,
                    color: floorStateManager.isEdited
                        ? Colors.blueAccent
                        : Colors.grey,
                    size: floorStateManager.isEdited ? 30 : 25,
                  )),
              IconButton(
                icon: const Icon(
                  CupertinoIcons.settings,
                  size: 27,
                ),
                onPressed: () {
                  addTable(floorStateManager);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  addTable(floorStateManager);
                },
              ),
              GestureDetector(
                onTap: () async {
                  await _controller.showTooltip();
                },
                child: SuperTooltip(
                  showBarrier: true,
                  controller: _controller,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.redAccent, size: 16),
                          const SizedBox(width: 8),
                          const Text('Tavolo occupato',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.circle,
                              color: Colors.green.shade600, size: 16),
                          const SizedBox(width: 8),
                          const Text('Tavolo libero',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Prenotazioni da assegnare:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('- Prenotazione 1',
                              style: TextStyle(fontSize: 14)),
                          Text('- Prenotazione 2',
                              style: TextStyle(fontSize: 14)),
                          Text('- Prenotazione 3',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  child: const Icon(
                    CupertinoIcons.info,
                    size: 27,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 30,
                ),
                onPressed: () {
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
                  children: floorStateManager.currentFloor.tables.map((table) {
                    return Positioned(
                        left: table.offsetX,
                        top: table.offsetY,
                        child: Draggable<TableConfDTO>(
                          data: table,
                          feedback: TableWidget(
                            table: table,
                            isDragging: true,
                            onToggleOrientation: () {},
                            bookings: [],
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.2,
                            child: TableWidget(
                              table: table,
                              onToggleOrientation: () {},
                              bookings: [],
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

                              table.offsetX = newX;
                              table.offsetY = newY;
                            });
                            floorStateManager.turnIsEdited();
                          },
                          child: DragTarget<String>(
                            onAcceptWithDetails: (bookingCode) {
                              print('Booking code: $bookingCode');
                              floorStateManager.turnIsEdited();

                              assignBookingToTable(floorStateManager,
                                  table.tableCode!, bookingCode.data!);
                            },
                            builder: (context, candidateData, rejectedData) {
                              return TableWidget(
                                table: table,
                                highlight: candidateData.isNotEmpty,
                                bookings: widget.bookingsIncoming,
                                onToggleOrientation: () {
                                  setState(() {
                                    table.orientation = table.orientation ==
                                            TableConfDTOOrientationEnum.VERTICAL
                                        ? TableConfDTOOrientationEnum.HORIZONTAL
                                        : TableConfDTOOrientationEnum.VERTICAL;
                                  });
                                  floorStateManager.turnIsEdited();
                                },
                              );
                            },
                          ),
                        ));
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
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      return Draggable<String>(
                        data: booking.bookingCode,
                        feedback:
                            BookingWidget(booking: booking, isDragging: true),
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
  final TableConfDTO table;
  final bool isDragging;
  final bool highlight;
  final VoidCallback onToggleOrientation;
  final List<BookingDTO> bookings;

  const TableWidget({
    super.key,
    required this.table,
    this.isDragging = false,
    this.highlight = false,
    required this.onToggleOrientation,
    required this.bookings,
  });

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    Size tableSize = getTableSize(widget.table.partyNumber!);

    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider value,
          Widget? child) {
        BookingDTO bookingDTO = BookingDTO(
            numGuests: 0,
            customer: CustomerDTO(
              firstName: '',
              lastName: '',
            ));
        if (widget.table.tableBookingCalendarConf.isNotEmpty) {
          widget.bookings
              .where((element) =>
                  element.bookingCode ==
                  widget.table.tableBookingCalendarConf[0].bookingCode)
              .forEach((element) {
            bookingDTO = element;
          });
        }
        return GestureDetector(
          onDoubleTap: widget.onToggleOrientation,
          onTap: () {
            if (widget.table.tableCode != null) {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: const Text(
                      'Gestione Tavolo',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    message: Text(
                      'Vuoi rimuovere la prenotazione dal tavolo "${widget.table.tableBookingCalendarConf.length}"?',
                      style: const TextStyle(fontSize: 16),
                    ),
                    actions: [
                      ...widget.table.tableBookingCalendarConf.map((conf) {
                        return CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context); // Close the sheet

                            // Remove reservation from table
                            Provider.of<FloorStateManagerProvider>(context,
                                    listen: false)
                                .removeReservationFromTable(
                                    widget.table.tableCode!, conf.bookingCode!);
                          },
                          child: Text(
                            'Rimuovi Prenotazione ${conf.bookingCode}',
                            style: const TextStyle(
                                color: CupertinoColors.systemRed, fontSize: 15),
                          ),
                        );
                      }).toList(),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          value.deleteTable(widget.table.tableCode!);
                          Navigator.pop(context); // Close the sheet
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
                      badgeColor: bookingDTO.numGuests! > 0
                          ? Colors.redAccent
                          : Colors.green.shade600),
                  badgeContent: Text(
                    bookingDTO.numGuests! > 0
                        ? bookingDTO.numGuests.toString()
                        : widget.table.partyNumber.toString(),
                    style: const TextStyle(
                        fontSize: 8, color: CupertinoColors.white),
                  ),
                  badgeAnimation: const badges.BadgeAnimation.slide(),
                  child: Card(
                    elevation: bookingDTO.numGuests! > 0 ? 1 : 9,
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
                        border:
                            Border.all(color: Colors.grey.shade600, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Builder(
                        builder: (BuildContext context) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.table.tableBookingCalendarConf.isNotEmpty
                                    ? Column(
                                        children: [
                                          Text(
                                            bookingDTO.customer!.firstName!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: blackDir,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            bookingDTO.customer!.lastName!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: blackDir,
                                              fontSize: 7,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )
                                    : IconButton(
                                        onPressed: () {}, icon: Icon(Icons.add))
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
                  style:
                      const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
