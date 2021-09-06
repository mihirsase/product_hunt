extension StringExtension on String? {


  DateTime? toDateTime() {
    if (this == null) {
      return null;
    } else {
      return DateTime.parse(this!);
    }
  }


}
