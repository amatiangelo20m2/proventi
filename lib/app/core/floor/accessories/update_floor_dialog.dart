import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:http/http.dart';
import '../../../../global/style.dart';

class EditFloorDialog extends StatelessWidget {
  final FloorDTO floorDTO;

  EditFloorDialog({
    required this.floorDTO,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = floorDTO.floorName ?? '';
    String description = floorDTO.floorDescription ?? '';

    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider floorStateManager, Widget? child) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Modifica sala', style: TextStyle(fontSize: 12)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CupertinoTextField(
                    placeholder: 'Name',
                    controller: TextEditingController(text: name),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    placeholder: 'Description',
                    controller: TextEditingController(text: description),
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

                  floorDTO.floorName = name;
                  floorDTO.floorDescription = description;

                  Response? floorDTOUpdated = await floorStateManager.floorControllerApi.updateFloorConfigurationWithHttpInfo(floorDTO.branchCode!, floorDTO);

                  if (floorDTOUpdated.statusCode == 200) {
                    floorStateManager.updateFloor(floorDTOUpdated.body as FloorDTO);
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: "Sala aggiornata con successo",
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: blackDir,
                      timeInSecForIosWeb: 5,
                      fontSize: 18.0,
                    );
                  }else{
                    Fluttertoast.showToast(
                      msg: "Errore durante l'aggiornamento della sala",
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: blackDir,
                      timeInSecForIosWeb: 5,
                      fontSize: 18.0,
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
              child: const Text('Aggiorna'),
            ),
            TextButton(
              onPressed: () async {
                bool? confirmDelete = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Conferma eliminazione'),
                      content: const Text('Sei sicuro di voler eliminare la sala?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Annulla'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Elimina'),
                        ),
                      ],
                    );
                  },
                );

                if (confirmDelete == true) {
                  await floorStateManager.deleteFloor(floorDTO.branchCode!, floorDTO.floorCode!);
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                    msg: "Sala eliminata con successo",
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: blackDir,
                    timeInSecForIosWeb: 5,
                    fontSize: 18.0,
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}