import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateTime() {
    return DateFormat('dd MMM yyyy').format(this.toLocal()).toString() +
        ' at ' +
        DateFormat('hh:mm a').format(this.toLocal()).toString();
  }

  String toTime() {
    return DateFormat('HH:mm').format(this.toLocal()).toString();
  }

  String toDate() {
    return DateFormat('yyyy-MM-dd').format(this.toLocal()).toString();
  }
}
