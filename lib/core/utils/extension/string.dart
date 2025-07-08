import 'package:intl/intl.dart';

extension StringExtension on String {
  String toDdMmYy() {
    try {
      final date = DateTime.parse(this);
      return DateFormat('dd/MM/yy').format(date);
    } on Exception {
      return '';
    }
  }
}
