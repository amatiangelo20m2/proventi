
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proventi/global/style.dart';

import '../api/restaurant_client/lib/api.dart';

const List<String> months = [
  'Gennaio',   // January
  'Febbraio',  // February
  'Marzo',     // March
  'Aprile',    // April
  'Maggio',    // May
  'Giugno',    // June
  'Luglio',    // July
  'Agosto',    // August
  'Settembre', // September
  'Ottobre',   // October
  'Novembre',  // November
  'Dicembre'   // December
];

bool isLunchTime(BookingDTO bookingDTO, RestaurantDTO restaurantConfiguration) {
  if (bookingDTO.timeSlot == null || restaurantConfiguration.daylyTimeWorkingRange == null || restaurantConfiguration.nightTimeWorkingRange == null) {
    return false;
  }

  // Get the booking hour and minutes from the bookingDTO
  final int bookingHour = bookingDTO.timeSlot!.bookingHour!;
  final int bookingMinutes = bookingDTO.timeSlot!.bookingMinutes!;

  // Get the lunch time range from the restaurant configuration
  final TimeRange lunchTimeRange = restaurantConfiguration.daylyTimeWorkingRange!;

  // Check if the booking hour is within the lunch time range
  bool isWithinLunchRange = false;
  if (bookingHour > lunchTimeRange.openingHour! || (bookingHour == lunchTimeRange.openingHour! && bookingMinutes >= lunchTimeRange.openingMinutes!)) {
    if (bookingHour < lunchTimeRange.closingHour! || (bookingHour == lunchTimeRange.closingHour! && bookingMinutes < lunchTimeRange.closingMinutes!)) {
      isWithinLunchRange = true;
    }
  }

  if (isWithinLunchRange) {
    return true;
  }

  // If not in lunch range, check dinner range (night time)
  final TimeRange dinnerTimeRange = restaurantConfiguration.nightTimeWorkingRange!;
  bool isWithinDinnerRange = false;
  if (bookingHour > dinnerTimeRange.openingHour! || (bookingHour == dinnerTimeRange.openingHour! && bookingMinutes >= dinnerTimeRange.openingMinutes!)) {
    if (bookingHour < dinnerTimeRange.closingHour! || (bookingHour == dinnerTimeRange.closingHour! && bookingMinutes < dinnerTimeRange.closingMinutes!)) {
      isWithinDinnerRange = true;
    }
  }

  if (isWithinDinnerRange) {
    return false;
  }


  return false;
}

String formatTimeRange(TimeRange timeRange) {
  // Ensure the required values are not null
  if (timeRange.openingHour == null || timeRange.openingMinutes == null || timeRange.closingHour == null || timeRange.closingMinutes == null) {
    return 'Invalid TimeRange';
  }

  // Format hours and minutes with padding to ensure two digits
  String formatTime(int hour, int minutes) {
    // Use `padLeft` to ensure hours and minutes are always 2 digits
    return '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  // Format both the opening and closing times
  String openingTime = formatTime(timeRange.openingHour!, timeRange.openingMinutes!);
  String closingTime = formatTime(timeRange.closingHour!, timeRange.closingMinutes!);

  // Return the formatted string
  return '$openingTime - $closingTime';
}

List<String> generateTimeSlots(TimeRange timeRange) {
  List<String> timeSlots = [];

  // Check if the time ranges are valid. If not, use default values.
  int startLunchHour = timeRange.openingHour ?? 12; // Default to 12 if null
  int startLunchMinute = timeRange.openingMinutes ?? 0; // Default to 0 if null
  int endLunchHour = timeRange.closingHour ?? 14; // Default to 14 (2 PM) if null
  int endLunchMinute = timeRange.closingMinutes ?? 0; // Default to 0 if null

  // Create time slots for lunch
  DateTime startLunch = DateTime(0, 0, 0, startLunchHour, startLunchMinute);
  DateTime endLunch = DateTime(0, 0, 0, endLunchHour, endLunchMinute);

  while (startLunch.isBefore(endLunch) || startLunch.isAtSameMomentAs(endLunch)) {
    timeSlots.add(DateFormat('H:mm').format(startLunch));
    startLunch = startLunch.add(const Duration(minutes: 15));
  }

  return timeSlots;
}


