import 'dart:ffi';

import 'package:albatrus/dashboard/left-column.dart';
import 'package:albatrus/dashboard/right-column.dart';
import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(15.0),
      width: 400.0,
      height: 100.0,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LeftColumn(name: 'asia butkiewicz', country: 'radom', date: '13.08.23'),
          RightColumn(),
        ],
      ),
    );
  }
}
