import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class Floor extends StatefulWidget {

  const Floor({super.key});

  static const String routeName = 'floor';

  @override
  State<Floor> createState() => _FloorState();
}

class _FloorState extends State<Floor> {
  // Map to store droppable positions (index, Offset)
  final Map<int, Offset> droppablePositions = {
    0: const Offset(10, 100),
    1: const Offset(100, 200),
    2: const Offset(100, 300),
    3: const Offset(300, 300),
    4: const Offset(140, 400),
    5: const Offset(600, 300),
    6: const Offset(500, 900),
    7: const Offset(10, 900),
    8: const Offset(20, 900),
    9: const Offset(100, 900),
  };

  // Track the state of each droppable position
  final Map<int, String> droppedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Cartesian Grid Background
          CustomPaint(
            size: Size.infinite,
            painter: CartesianPainter(),
          ),
          // Draggable Item
          const Draggable<String>(
            data: "P 1",
            feedback: Material(
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30,
                child: Text(
                  "Res",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            childWhenDragging: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
              child: Text(
                "P1",
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 30,
              child: Text(
                "P1",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Draggable Droppable Areas
          ...droppablePositions.entries.map((entry) {
            final index = entry.key;
            final position = entry.value;

            return Positioned(
              left: position.dx,
              top: position.dy,
              child: Draggable<Offset>(
                data: position,
                feedback: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 50,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  width: 50,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
                child: DragTarget<Offset>(
                  onAccept: (data) {
                    setState(() {
                      droppedItems[index] = "Px 1";
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    final isDropped = droppedItems.containsKey(index);

                    return Container(
                      width: 50,
                      height: 100,
                      decoration: BoxDecoration(
                        color: isDropped ? Colors.blueAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: badges.Badge(
                        badgeContent: Text('3', style: TextStyle(color: CupertinoColors.white)),
                        child: Text(
                          isDropped ? droppedItems[index]! : "+",
                          style: const TextStyle(color: Colors.white, fontSize: 26),
                        ),
                      ),
                    );
                  },
                ),
                onDragEnd: (details) {
                  setState(() {
                    droppablePositions[index] = details.offset;
                  });
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Custom Painter to draw a grid
class CartesianPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += 25) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += 25) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}