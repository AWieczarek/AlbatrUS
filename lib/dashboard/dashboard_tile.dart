import 'dart:ffi';

import 'package:albatrus/custom_colors.dart';
import 'package:albatrus/dashboard/date_format.dart';
import 'package:albatrus/dashboard/dashboard_tile_left_column.dart';
import 'package:albatrus/dashboard/dashboard_tile_right_column.dart';
import 'package:flutter/material.dart';
import 'package:albatrus/models/trip.dart';

class DashboardTile extends StatelessWidget {
  final Trip trip;

  DashboardTile({super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          //color: CustomColors().myGrayColor,
          border: Border.all(
            color: CustomColors().myGrayColor,
            width: 2.0,
          ),
        ),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        //width: 400.0,
        height: 120.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LeftColumn(name: trip.user.username, dateFrom: trip.dateFrom, city: trip.city, country: trip.country),
            RightColumn(trip:trip),
          ],
        ),
      ),
    );
  }
}
