import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';

import '../../../../global/style.dart';
import '../floor.dart';

class CreateFloorDialog extends StatelessWidget {
  final String branchCode;
  final List<BookingDTO> bookingList;
  final DateTime selectedDate;

  CreateFloorDialog({
    required this.branchCode,
    required this.bookingList,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = '';
    String description = '';

    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider floorStateManager, Widget? child) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Crea una nuova sala', style: TextStyle(fontSize: 12)),
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
                    branchCode: branchCode,
                    floorDescription: description,
                    floorId: 0,
                    floorCode: const Uuid().v4(),
                  ));

                  if(floorStateManager.floorList!.length>1) {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: "Sala creata con successo",
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: blackDir,
                      timeInSecForIosWeb: 5,
                      fontSize: 18.0,
                    );
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Floor(
                          bookingsIncoming: bookingList,
                          currentSelectedDate: selectedDate,
                        ),
                      ),
                    );
                  }

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
}