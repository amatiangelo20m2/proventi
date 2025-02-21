import 'dart:ui';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../api/restaurant_client/lib/api.dart';

var globalGold = const Color(0xFFD4B26A);
var globalGoldDark = const Color(0xFFC19738);
var elegantRed = const Color(0xFFD32F2F);
var elegantGreen = const Color(0xFF60A757);
var elegantBlue = const Color(0xFF001E28);
var blackDir = const Color(0xFF1E1F22);
var purple = const Color(0xFFC77DBB);

DateFormat italianDateFormat = DateFormat('EEEE d MMMM y', 'it_IT');

DateFormat italianDateFormatWithTime = DateFormat('EEEE d MMMM y HH:mm', 'it_IT');

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
      return Colors.blueAccent.withAlpha(200);
    case BookingDTOStatusEnum.IN_ATTESA:
      return elegantRed.withAlpha(200);
    case BookingDTOStatusEnum.RIFIUTATO:
      return elegantRed.withAlpha(200);
    case BookingDTOStatusEnum.ARRIVATO:
      return elegantGreen.withAlpha(200);
    case BookingDTOStatusEnum.NON_ARRIVATO:
      return Colors.grey.withAlpha(200);
    case BookingDTOStatusEnum.LISTA_ATTESA:
      return Colors.pink.withAlpha(200);
    case BookingDTOStatusEnum.MODIFICATO_DA_UTENTE:
      return Colors.deepOrange.withAlpha(200);
    case BookingDTOStatusEnum.ELIMINATO:
      return elegantRed.withAlpha(200);
    case BookingDTOStatusEnum.MODIFICA_CONFERMATA:
      return globalGoldDark.withAlpha(200);
    default:
      return CupertinoColors.systemGrey.withAlpha(200);
  }

}

String getIconByStatus(BookingDTOStatusEnum statusEnum) {

  switch (statusEnum) {
    case BookingDTOStatusEnum.CONFERMATO:
      return '🆗';
    case BookingDTOStatusEnum.IN_ATTESA:
      return '⏳';
    case BookingDTOStatusEnum.RIFIUTATO:
      return '❌';
    case BookingDTOStatusEnum.ARRIVATO:
      return '✅';
    case BookingDTOStatusEnum.NON_ARRIVATO:
      return '⚠️';
    case BookingDTOStatusEnum.LISTA_ATTESA:
      return '👥';
    case BookingDTOStatusEnum.MODIFICATO_DA_UTENTE:
      return '🖋️';
    case BookingDTOStatusEnum.ELIMINATO_DA_UTENTE:
      return '❌';
    case BookingDTOStatusEnum.ELIMINATO:
      return '🗑';
    default:
      return '';
  }
}


void showCupertinoAlert(BuildContext context, String title, String message) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title, style: TextStyle(fontFamily: globalFontFamily),),
        content: Text(message, style: TextStyle(fontFamily: globalFontFamily)),
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

String getFormEmoji(List<FormDTO> formDTOs, BookingDTO booking) {
  if (formDTOs.isEmpty || booking.formCode == null || booking.formCode!.isEmpty) {
    return '';
  }

  var matchingForm = formDTOs.firstWhere(
        (element) => element.formCode == booking.formCode,
    orElse: () => FormDTO(formCode: '', outputNameForCustomer: ''),
  );

  if (matchingForm.outputNameForCustomer == null) {
    return '';
  }

  return matchingForm.outputNameForCustomer!;
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

double getRelativeSize(BuildContext context, double size) {
  // Get the screen width
  double screenWidth = MediaQuery.of(context).size.width;
  double relativeSize = size * (screenWidth / 375); // 375 is the design width (reference screen size)

  return relativeSize;
}

String? globalFontFamily = GoogleFonts.nunito().fontFamily;