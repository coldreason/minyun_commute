import 'package:commute/utils/helpers/masks.dart';

String getMonthString(DateTime date) {
  return date.year.toString() + dateStringFormatter.format(date.month);
}

String getDateString(DateTime date) {
  return getMonthString(date) + dateStringFormatter.format(date.day);
}

String dateTimeToString(DateTime dateTime) {
  return "${dateStringFormatter.format(dateTime.hour)}:${dateStringFormatter.format(dateTime.minute)}";
}