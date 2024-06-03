import 'package:intl/intl.dart';

class DateFormatter {
  // class which provides different options to format date and time
  static String formatDateTime(DateTime dateTime) =>
      DateFormat('dd-MM-yy HH:mm').format(dateTime);

  static String getDayasText(DateTime dateTime) {
    // function get day's as text such as monday , tuesday etc
    final dayFormatter = DateFormat('EEEE'); // EEEE for full weekday name
    String dayName = dayFormatter.format(dateTime);
    return dayName;
  }

  static String formatTime(DateTime dateTime) =>
      // function to get time in AM/PM format
      DateFormat('hh:mm a').format(dateTime);

  static bool isPastOneDay(int previousTime) =>
      // function to check weather given time has passed one day
      DateTime.now().millisecondsSinceEpoch - previousTime > 86400000
          ? true
          : false;
}
