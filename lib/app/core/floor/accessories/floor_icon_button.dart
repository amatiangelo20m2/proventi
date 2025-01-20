import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:provider/provider.dart';
import 'dialog_helper.dart';
import '../floor.dart';

class FloorIconButton extends StatefulWidget {
  const FloorIconButton({
    super.key,
    required this.branchCode,
    required this.bookingList,
    required this.selectedDate,
  });

  final String branchCode;
  final List<BookingDTO> bookingList;
  final DateTime selectedDate;

  @override
  _FloorIconButtonState createState() => _FloorIconButtonState();
}

class _FloorIconButtonState extends State<FloorIconButton> {
  late Future<List<FloorDTO>?> _futureFloors;

  @override
  void initState() {
    super.initState();
    _futureFloors = _fetchFloors();
  }

  Future<List<FloorDTO>?> _fetchFloors() async {
    final floorStateProvider = Provider.of<FloorStateManagerProvider>(context, listen: false);
    final floors = await floorStateProvider.floorControllerApi.getFloorByBranchCodeAndDate(widget.branchCode);
    floorStateProvider.setFloorList(floors!);
    floorStateProvider.setBookingList(widget.bookingList);
    return floors;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FloorDTO>?>(
      future: _futureFloors,
      builder: (BuildContext context, AsyncSnapshot<List<FloorDTO>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        } else if (snapshot.hasError) {
          return IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Errore nel caricamento dei dati, riprova fra 2 minuti..'),
                ),
              );
            },
            icon: const Icon(Icons.error, color: Colors.red),
          );
        } else {
          if (snapshot.data!.isEmpty) {
            return IconButton(
              onPressed: () {
                DialogHelper.showAddFloorDialog(
                  context,
                  Provider.of<FloorStateManagerProvider>(context, listen: false),
                  widget.branchCode,
                  widget.bookingList,
                  widget.selectedDate,
                );
              },
              icon: const Icon(Icons.table_restaurant, color: Colors.blueGrey),
            );
          } else {
            return IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Floor(
                      bookingsIncoming: widget.bookingList,
                    ),
                  ),
                );
              },

              icon: const Icon(Icons.table_restaurant, color: Colors.black),
            );
          }
        }
      },
    );
  }
}