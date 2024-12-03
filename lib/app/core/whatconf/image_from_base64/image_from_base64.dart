import 'dart:convert'; // Required for base64Decode
import 'dart:typed_data'; // Required for Uint8List
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../global/style.dart';

Widget buildImageFromBase64(String? base64ImageString) {
  if (base64ImageString == null || base64ImageString.isEmpty) {
    return Text("No base64 found code available.");
  }

  if (base64ImageString == null || base64ImageString.isEmpty) {
    return Text("No base64 found code available.");
  }

  // Remove the data URL prefix if it exists
  final RegExp regex = RegExp(r'data:image\/[a-zA-Z]+;base64,');
  base64ImageString = base64ImageString.replaceAll(regex, '');


  // Decode the base64 string into bytes
  Uint8List imageBytes;
  try {
    imageBytes = base64Decode(base64ImageString);
  } catch (e) {
    return Text("String base 64 is invalid [ $base64ImageString ]");
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.memory(
        imageBytes,
        width: 300,
        height: 300,
        fit: BoxFit.cover, // Adjust as needed
      ),
      LinearProgressIndicator(
        color: globalGold,
      ),
      Text('Scannerizza il QR code per collegare numero whatsapp',style: TextStyle(fontSize: 7),)
    ],
  );
}
