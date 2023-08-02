import 'package:intl/intl.dart';

extension StringFormat on DateTime {
  String get dateFormatted => DateFormat("EEE, MMM d, y").format(this);

  String get dateAndTimeFormatted =>
      DateFormat("EEE, MMM d, y - hh:mm a").format(this);

  String get timeFormatted => DateFormat("HH:mm").format(this);
}
