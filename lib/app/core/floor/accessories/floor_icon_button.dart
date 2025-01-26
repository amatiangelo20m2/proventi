import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../global/style.dart';
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

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider floorStateManager, Widget? child) {
        return IconButton(
          onPressed: () async {
            await floorStateManager.loadData(widget.branchCode, widget.selectedDate);
            if(floorStateManager.floorList!.isNotEmpty){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Floor(
                    bookingsIncoming: widget.bookingList,
                    currentSelectedDate: widget.selectedDate,
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final _formKey = GlobalKey<FormState>();
                  String name = '';
                  String description = '';

                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Crea una nuova sala', style: TextStyle(fontSize: 12),),
                    content: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CupertinoTextField(
                              placeholder: 'Name',
                              onChanged: (value) {
                                name = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            CupertinoTextField(
                              placeholder: 'Description',
                              onChanged: (value) {
                                description = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Indietro'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (name.isNotEmpty) {

                            await floorStateManager.createFloor(FloorDTO(
                              floorName: name,
                              branchCode: widget.branchCode,
                              floorDescription: description,
                              floorId: 0,
                              floorCode: const Uuid().v4(),
                            ));

                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Floor(
                                  bookingsIncoming: widget.bookingList,
                                  currentSelectedDate: widget.selectedDate,
                                ),
                              ),
                            );
                          } else {
                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text('Errore'),
                                  content: const Text('Il nome della sala è obbligatorio'),
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
                          }
                        },
                        child: const Text('Crea'),
                      ),
                    ],
                  );
                },
              );
            }

          },

          icon: Icon(Icons.table_restaurant, color: blackDir),
        );
      },
    );
  }
}