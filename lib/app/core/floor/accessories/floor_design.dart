import 'dart:ui';

import 'package:flutter/material.dart';

Size getTableSize(int partySize) {
  if (partySize <= 2) {
    return const Size(70, 70);
  } else if (partySize <= 7) {
    return const Size(100, 70);
  } else if (partySize <= 12) {
    return const Size(140, 70);
  } else if (partySize <= 16) {
    return const Size(180, 70);
  } else if(partySize <= 20){
    return const Size(220, 70);
  }else{
    return const Size(250, 70);
  }
}

Color getMatchingColor(int partyNumber, int numGuests) {
  int difference = (numGuests - partyNumber).abs();

  if (difference == 0) {
    return Colors.green.withAlpha(180); // Exact match
  } else if (difference == 1) {
    return Colors.teal.withAlpha(180); // ±1
  } else if (difference == 2) {
    return Colors.blue.withAlpha(180); // ±2
  } else if (difference == 3) {
    return Colors.orange.withAlpha(180); // ±3
  } else {
    return Colors.red.withAlpha(180); // ±3
  }
}
