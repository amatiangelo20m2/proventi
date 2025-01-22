import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/app/core/floor/accessories/update_floor_dialog.dart';
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_floor_dialog.dart';

class FloorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FloorStateManagerProvider>(
      builder: (context, floorStateProvider, child) {
        return Drawer(

          child: ListView.builder(
            itemCount: (floorStateProvider.floorList?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Create Nuova Sala'),

                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String branchCode = prefs.getString('branchCode').toString();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateFloorDialog(
                          branchCode: branchCode,
                          bookingList: [], // Replace with actual booking list
                          selectedDate: DateTime.now(), // Replace with actual selected date
                        );
                      },
                    );
                  },
                );
              }

              final floor = floorStateProvider.floorList![index - 1];
              final isSelected = floor.floorCode == floorStateProvider.currentFloor.floorCode;

              return ListTile(
                leading: isSelected
                    ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green.withAlpha(200))
                    : Icon(CupertinoIcons.circle, color: Colors.grey),
                onTap: isSelected
                    ? null
                    : () {
                  floorStateProvider.setCurrentFloor(floor.floorCode!);
                  Navigator.of(context).pop(); // Close the drawer
                },
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      floor.floorName!,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Text(
                      '${floor.tables.length!} tavoli',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                    ),
                  ],
                ),
                trailing: IconButton(onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditFloorDialog(
                        floorDTO: floor,
                      );
                    },
                  );
                }, icon: const Icon(CupertinoIcons.settings, color: Colors.grey,),)
              );
            },
          ),
        );
      },
    );
  }
}