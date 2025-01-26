import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proventi/app/core/floor/accessories/floor_table.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:http/http.dart';
import '../../../../global/style.dart';

class EditTableFloorDialog extends StatefulWidget {
  final String floorCode;
  final TableConfDTO tableConfDTO;

  EditTableFloorDialog({
    required this.floorCode, required this.tableConfDTO,
  });

  @override
  State<EditTableFloorDialog> createState() => _EditTableFloorDialogState();
}

class _EditTableFloorDialogState extends State<EditTableFloorDialog> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late int? partyNumber;

  @override
  void initState() {
    super.initState();
    name = widget.tableConfDTO.tableName ?? '';
    partyNumber = widget.tableConfDTO.partyNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FloorStateManagerProvider>(
      builder: (BuildContext context, FloorStateManagerProvider floorStateManager, Widget? child) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Modifica tavolo', style: TextStyle(fontSize: 12)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CupertinoTextField(
                    placeholder: 'Nome',
                    controller: TextEditingController(text: name),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<int>(
                    value: partyNumber,
                    items: List.generate(24, (index) => index + 1)
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
                          partyNumber = value;
                        });
                      }
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
                  widget.tableConfDTO.tableName = name;
                  widget.tableConfDTO.partyNumber = partyNumber;

                  Response responseAfterUpdateTable = await floorStateManager
                      .floorControllerApi.updateTableWithHttpInfo(widget.tableConfDTO.tableCode!, widget.tableConfDTO.tableName!, widget.tableConfDTO.partyNumber!);

                  if (responseAfterUpdateTable.statusCode == 200) {
                    floorStateManager.updateTableConf(widget.floorCode, widget.tableConfDTO.tableCode!, widget.tableConfDTO.tableName!, widget.tableConfDTO.partyNumber!);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: "Tavolo aggiornato con successo",
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: blackDir,
                      timeInSecForIosWeb: 5,
                      fontSize: 18.0,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Errore durante l'aggiornamento",
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
                        content: const Text('Il nome della tavolo è obbligatorio'),
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
          ],
        );
      },
    );
  }
}