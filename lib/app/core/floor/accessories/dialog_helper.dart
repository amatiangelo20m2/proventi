import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:uuid/uuid.dart';

import '../floor.dart';

class DialogHelper {
  static void showAddFloorDialog(BuildContext context, FloorStateManagerProvider floorStateProvider, String branchCode, List<BookingDTO> bookingList, DateTime currentSelectedDate) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crea nuova sala', style: TextStyle(color: Colors.grey.shade700)),
          content: Column(
            children: [
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Nome della sala',
              ),
              CupertinoTextField(
                controller: descriptionController,
                placeholder: 'Descrizione',
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                String name = nameController.text;
                if (name.isNotEmpty) {
                  // Create a new FloorDTO

                  FloorDTO newFloor = FloorDTO(
                    floorName: name,
                    branchCode: branchCode,
                    floorDescription: descriptionController.text,
                    floorId: 0,
                    floorCode: const Uuid().v4(),
                  );
                  await floorStateProvider.createFloor(newFloor);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}