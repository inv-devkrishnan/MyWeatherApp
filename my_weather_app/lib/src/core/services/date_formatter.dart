import 'package:intl/intl.dart';

class DateFormatter {
  // class which provides different options to format date and time
  static String formatDateTime(DateTime dateTime) =>
      DateFormat('dd-MM-yy HH:mm').format(dateTime);

  static String getDayasText(DateTime dateTime) {
    final dayFormatter = DateFormat('EEEE'); // EEEE for full weekday name
    String dayName = dayFormatter.format(dateTime);
    return dayName;
  }

  static String formatTime(DateTime dateTime) =>
      DateFormat('HH:mm').format(dateTime);
}
