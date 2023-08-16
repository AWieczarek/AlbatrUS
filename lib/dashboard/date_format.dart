import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;
  final Color textColor;
  final double fontSize;

  DateWidget({super.key, required this.date, required this.textColor, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = date;
    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);

    return Text(
      formattedDate,
      style: TextStyle(fontSize: fontSize, color: textColor),
    );
  }
}
