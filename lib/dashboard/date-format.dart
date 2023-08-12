import 'package:flutter/material.dart';
import 'package:intl/intl.dart;

class MyDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Formatted Date: $formattedDate',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}