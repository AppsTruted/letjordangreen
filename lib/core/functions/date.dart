import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime) {
  String formattedDate = DateFormat('dd/MM/yy').format(dateTime.toLocal());
  return formattedDate;
}
String getFormattedDateDash(DateTime dateTime, {String? local}) {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy / h:mm a', local!=null ? local : "en");
  String formattedDate = dateFormat.format(dateTime.toLocal());
  return formattedDate;
}
String getFormattedDateDashboard(DateTime dateTime, {String? local}) {
  final DateFormat dateFormat = DateFormat('dd MMMM yyyy EEEE | HH:mm', local != null ? local : "en");
  String formattedDate = dateFormat.format(dateTime.toLocal());
  return formattedDate;
}
String getFormattedTime(DateTime dateTime) {
  final DateFormat timeFormat = DateFormat('HH:mm a');
  return timeFormat.format(dateTime.toLocal());
}
String getFormattedMatchTime(String time, BuildContext context) {
  final locale = context.locale.languageCode;
  final DateTime dateTime = DateTime.parse('2000-01-01 $time:00');

  // Let Intl handle locale-specific time formatting
  return DateFormat('h:mm a', locale).format(dateTime);
}

String getFormattedDateMMMddYYYY(DateTime dateTime, {String? local}) {
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  String formattedDate = dateFormat.format(dateTime.toLocal());
  return formattedDate;
}
String getFormattedDateMenu(DateTime dateTime, {String? local}) {
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  String formattedDate = dateFormat.format(dateTime.toLocal());
  return formattedDate;
}
String getFormattedMatchDate(DateTime dateTime) {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(dateTime.toLocal());
}
bool isCurrentTimeBetween(String startTimeStr, String endTimeStr) {
  TimeOfDay startTime = TimeOfDay(
    hour: int.parse(startTimeStr.split(":")[0]),
    minute: int.parse(startTimeStr.split(":")[1]),
  );

  TimeOfDay endTime = TimeOfDay(
    hour: int.parse(endTimeStr.split(":")[0]),
    minute: int.parse(endTimeStr.split(":")[1]),
  );

  TimeOfDay now = TimeOfDay.now();

  bool isAfterStart = now.hour > startTime.hour ||
      (now.hour == startTime.hour && now.minute >= startTime.minute);

  bool isBeforeEnd = now.hour < endTime.hour ||
      (now.hour == endTime.hour && now.minute <= endTime.minute);

  return isAfterStart && isBeforeEnd;
}

List<String> generateDaysList() {
  final now = DateTime.now();

  List<String> daysList = [];

  for (int i = 0; i < 7; i++) {
    DateTime day = now.add(Duration(days: i));
    String label;

    if (i == 0) {
      label = "Today";
    } else if (i == 1) {
      label = "Tomorrow";
    } else {
      label = getWeekdayName(day.weekday);
    }

    daysList.add(label);
  }

  return daysList;
}

String getWeekdayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "Monday";
    case DateTime.tuesday:
      return "Tuesday";
    case DateTime.wednesday:
      return "Wednesday";
    case DateTime.thursday:
      return "Thursday";
    case DateTime.friday:
      return "Friday";
    case DateTime.saturday:
      return "Saturday";
    case DateTime.sunday:
      return "Sunday";
    default:
      return "";
  }
}


String? getScheduledDateTimeISO({
  required String? selectedOption,
  required String? selectedDay,
  required String? selectedTime,
}) {
  if (selectedOption == null || selectedOption == 'ASAP') {
    return null;
  }

  if (selectedDay == null || selectedTime == null) {
    return null;
  }

  final now = DateTime.now();

  int daysToAdd = 0;

  if (selectedDay == 'Today') {
    daysToAdd = 0;
  } else if (selectedDay == 'Tomorrow') {
    daysToAdd = 1;
  } else {
    const dayMap = {
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };

    int selectedWeekday = dayMap[selectedDay] ?? 1;
    int diff = (selectedWeekday - now.weekday) % 7;

    if (diff == 0) {
      diff = 7;
    }

    daysToAdd = diff;
  }

  final targetDate = now.add(Duration(days: daysToAdd));

  final parts = selectedTime.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);

  DateTime scheduledDate = DateTime(
    targetDate.year,
    targetDate.month,
    targetDate.day,
    hour,
    minute,
  );

  if (daysToAdd == 0 && scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  return scheduledDate.toIso8601String();
}
