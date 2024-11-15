import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/restaurant_client/lib/api.dart';
import '../app/core/booking/crud_widget/create_booking_lista_attesa.dart';

var globalGold = Color(0xFFD4B26A);
var globalGoldDark = Color(0xFFae801f);
var elegantRed = Color(0xFFD32F2F);
var elegantGreen = Color(0xFF4CAF50);
var elegantBlue = Color(0xFF3A6EA5);

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
      return elegantGreen;
    case BookingDTOStatusEnum.IN_ATTESA:
      return globalGold;
    case BookingDTOStatusEnum.RIFIUTATO:
      return elegantRed;
    case BookingDTOStatusEnum.ARRIVATO:
      return elegantBlue;
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
getSourceEmoji(BookingDTOBookingSourceEnum source) {
  switch(source){
    case BookingDTOBookingSourceEnum.APP:
      return '';
    case BookingDTOBookingSourceEnum.APP_CUSTOMER:
      return '';
    case BookingDTOBookingSourceEnum.WEB:
      return '';
    default:
      return '';
  }
}

String formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60); // Get the remainder minutes after extracting hours

  // Format the output as hh:mm
  String formattedTime = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  return formattedTime;
}
