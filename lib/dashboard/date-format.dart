import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {

  final DateTime date;

  DateWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = date;
    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);

    return Text(
        formattedDate,
        style: const TextStyle(fontSize: 14.0),
    );
  }
}