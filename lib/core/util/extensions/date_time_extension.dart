import 'package:intl/intl.dart';

enum DatePattern {
  diaMesHoraMinuto('dd/MM \'às\' HH\'h\'mm');

  final String value;

  const DatePattern(this.value);
}

extension DateTimeExtension on DateTime {
  String formatter(DatePattern pattern) =>
      DateFormat(pattern.value, 'pt_Br').format(this);
}
