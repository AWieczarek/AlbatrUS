import 'dart:ffi';

import 'package:albatrus/dashboard/date-format.dart';
import 'package:albatrus/dashboard/left-column.dart';
import 'package:albatrus/dashboard/right-column.dart';
import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final String name;
  final String place;
  final DateTime date;

  DashboardItem({super.key,
    required this.name,
    required this.date,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(15.0),
        width: 400.0,
        height: 120.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LeftColumn(name: name, country: place),
            RightColumn(),
          ],
        ),
      ),
    );
  }
}
