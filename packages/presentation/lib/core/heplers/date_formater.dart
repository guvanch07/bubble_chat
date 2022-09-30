import 'package:intl/intl.dart';

DateTime now = DateTime.now();

abstract class DateFormatter {
  static String timeformatter(DateTime? date) =>
      DateFormat('hh:mm a').format(date ?? now);
}
