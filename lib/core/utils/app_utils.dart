import 'package:intl/intl.dart';

class AppUtils {
  static String formatChatDate(DateTime dateTime) {
    var messageDate = dateTime;
    var currentDate = DateTime.now();
    var thisMonth = messageDate.year == currentDate.year &&
        messageDate.month == currentDate.month;
    var lastWeek = thisMonth && messageDate.day - currentDate.day < 7;
    var yesterday = thisMonth && messageDate.day == currentDate.day - 1;
    var today = thisMonth && messageDate.day == currentDate.day;

    if (today)
      return DateFormat.jm().format(messageDate);
    else if (yesterday)
      return "yesterday";
    else if (lastWeek)
      return DateFormat.EEEE().format(messageDate);
    else
      return DateFormat.yMd().format(messageDate);
  }
}
