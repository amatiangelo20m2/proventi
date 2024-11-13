import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/restaurant_client/lib/api.dart';
import '../app/core/booking/crud_widget/create_booking_lista_attesa.dart';

var globalBlue = Color(0xFF38b6FF);

DateFormat italianDateFormat = DateFormat('EEEE d MMMM y', 'it_IT');

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

getItalianMonthAbbreviation(monthNumber) {
  const italianMonths = [
    "Gen", // January - Gennaio
    "Feb", // February - Febbraio
    "Mar", // March - Marzo
    "Apr", // April - Aprile
    "Mag", // May - Maggio
    "Giu", // June - Giugno
    "Lug", // July - Luglio
    "Ago", // August - Agosto
    "Set", // September - Settembre
    "Ott", // October - Ottobre
    "Nov", // November - Novembre
    "Dic" // December - Dicembre
  ];

// Ensure the month number is valid
  if (monthNumber < 1 || monthNumber > 12) {
    return "Invalid month number. Please provide a number between 1 and 12.";
  }

  return italianMonths[monthNumber - 1];
}

Color getStatusColor(BookingDTOStatusEnum statusEnum) {
  switch (statusEnum) {
    case BookingDTOStatusEnum.CONFERMATO:
      return CupertinoColors.activeGreen;
    case BookingDTOStatusEnum.IN_ATTESA:
      return Colors.deepOrangeAccent;
    case BookingDTOStatusEnum.RIFIUTATO:
      return CupertinoColors.destructiveRed;
    case BookingDTOStatusEnum.ARRIVATO:
      return CupertinoColors.activeBlue;
    case BookingDTOStatusEnum.NON_ARRIVATO:
      return Colors.blueGrey;
    case BookingDTOStatusEnum.LISTA_ATTESA:
      return Colors.teal.shade300;
    case BookingDTOStatusEnum.MODIFICATO_DA_UTENTE:
      return Colors.purple;
    case BookingDTOStatusEnum.ELIMINATO:
      return CupertinoColors.black;
    default:
      return CupertinoColors.systemGrey;
  }
}

void showCupertinoAlert(BuildContext context, String title, String message) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

getFormEmoji(List<FormDTO> formDTOs, BookingDTO booking) {
  if(formDTOs.isEmpty || booking.formCode == ''){
    return '';
  }else{
    if(formDTOs.where((element) => element.formCode == booking.formCode).isEmpty){
      return '';
    }else {
      return formDTOs.where((element) => element.formCode == booking.formCode).first.outputNameForCustomer;
    }
  }
}
