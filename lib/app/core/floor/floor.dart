import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floor extends StatefulWidget {
  const Floor({super.key});

  static const String routeName = 'floor';

  @override
  State<Floor> createState() => _FloorState();
}

class _FloorState extends State<Floor> {
  @override
  Widget build(BuildContext context) {
    return RestaurantFloorOrganizer();
  }
}

class RestaurantFloorOrganizer extends StatefulWidget {
  @override
  _RestaurantFloorOrganizerState createState() =>
      _RestaurantFloorOrganizerState();
}

class _RestaurantFloorOrganizerState extends State<RestaurantFloorOrganizer> {
  List<TableItem> tables = [];
  List<Booking> bookings = [];
  bool draggableEnabled = true;

  double tableSize = 80.0; // Size of each table widget

  @override
  void initState() {
    super.initState();
    bookings = [
      Booking(id: 'b1', customerName: 'Alice', partySize: 2),
      Booking(id: 'b2', customerName: 'Bob', partySize: 4),
    ];
  }

  void addTable() async {
    int selectedSize = 2; // Default value

    int? partySize = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Table'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create a new table'),
                  DropdownButton<int>(
                    value: selectedSize,
                    items: List.generate(12, (index) => index + 1)
                        .map((size) => DropdownMenuItem<int>(
                      value: size,
                      child: Text('Table for $size'),
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
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, selectedSize), // Confirm
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );

    if (partySize != null) {
      setState(() {
        tables.add(TableItem(
          id: 't${tables.length + 1}',
          name: 'Table ${tables.length + 1} ($partySize)',
          partySize: partySize,
          position: Offset(100, 100),
        ));
      });
    }
  }

  void assignBookingToTable(String tableId, String bookingId) {
    setState(() {
      final table = tables.firstWhere((t) => t.id == tableId);
      table.bookingId = bookingId;

      // Remove the booking from the available list
      bookings.removeWhere((b) => b.id == bookingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Floor Organizer'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: addTable,
          ),
          Switch(
            value: draggableEnabled,
            onChanged: (value) {
              setState(() {
                draggableEnabled = value;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            child: Stack(
              children: tables.map((table) {
                return Positioned(
                  left: table.position.dx,
                  top: table.position.dy,
                  child: draggableEnabled
                      ? Draggable<TableItem>(
                    data: table,
                    feedback: TableWidget(
                      table: table,
                      isDragging: true,
                      onToggleOrientation: () {}, // No toggling while dragging
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

                        double newX =
                        (details.offset.dx - tableSize / 2).clamp(0.0, maxX);
                        double newY =
                        (details.offset.dy - tableSize / 2).clamp(0.0, maxY);

                        table.position = Offset(newX, newY);
                      });
                    },
                    child: DragTarget<String>(
                      onAccept: (bookingId) =>
                          assignBookingToTable(table.id, bookingId),
                      builder: (context, candidateData, rejectedData) {
                        return TableWidget(
                          table: table,
                          highlight: candidateData.isNotEmpty,
                          onToggleOrientation: () {
                            setState(() {
                              table.orientation =
                              table.orientation == Orientation.vertical
                                  ? Orientation.horizontal
                                  : Orientation.vertical;
                            });
                          },
                        );
                      },
                    ),
                  )
                      : DragTarget<String>(
                    onAccept: (bookingId) =>
                        assignBookingToTable(table.id, bookingId),
                    builder: (context, candidateData, rejectedData) {
                      return TableWidget(
                        table: table,
                        highlight: candidateData.isNotEmpty,
                        onToggleOrientation: () {
                          setState(() {
                            table.orientation =
                            table.orientation == Orientation.vertical
                                ? Orientation.horizontal
                                : Orientation.vertical;
                          });
                        },
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Draggable<String>(
                    data: booking.id,
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
  }
}

class TableWidget extends StatelessWidget {
  final TableItem table;
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggleOrientation,
      child: Material(
        child: Container(
          width: table.orientation == Orientation.vertical ? 60 : 120,
          height: table.orientation == Orientation.vertical ? 120 : 60,
          decoration: BoxDecoration(
            color: highlight ? Colors.pink.withOpacity(0.5) : Colors.pink,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              table.bookingId != null
                  ? 'Table ${table.name}\n(${table.bookingId})'
                  : table.name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class BookingWidget extends StatelessWidget {
  final Booking booking;
  final bool isDragging;

  const BookingWidget({required this.booking, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isDragging ? Colors.green.withOpacity(0.5) : Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${booking.customerName}\nGuests: ${booking.partySize}',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

enum Orientation { vertical, horizontal }

class TableItem {
  final String id;
  final String name;
  final int partySize;
  Offset position;
  Orientation orientation;
  String? bookingId;

  TableItem({
    required this.id,
    required this.name,
    required this.partySize,
    required this.position,
    this.orientation = Orientation.vertical,
    this.bookingId,
  });
}

class Booking {
  final String id;
  final String customerName;
  final int partySize;

  Booking({required this.id, required this.customerName, required this.partySize});
}
