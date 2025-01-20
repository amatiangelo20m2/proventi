import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proventi/app/core/floor/state_manager/floor_state_manager.dart';

class FloorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FloorStateManagerProvider>(
      builder: (context, floorStateProvider, child) {
        return Drawer(
          child: ListView.builder(
            itemCount: floorStateProvider.floorList?.length ?? 0,
            itemBuilder: (context, index) {
              final floor = floorStateProvider.floorList![index];
              final isSelected = floor.floorCode == floorStateProvider.currentFloor.floorCode;

              return ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      floor.floorName!,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      floor.floorDescription!,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 9),
                    ),
                  ],
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: isSelected
                    ? null
                    : () {
                  floorStateProvider.setCurrentFloor(floor.floorCode!);
                  Navigator.of(context).pop(); // Close the drawer
                },
              );
            },
          ),
        );
      },
    );
  }
}