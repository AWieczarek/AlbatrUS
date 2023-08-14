import 'package:albatrus/dashboard/dashboard-tile.dart';
import 'package:albatrus/models/user_short.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';





class AsiaSandbox extends StatelessWidget {
  final List<Trip> trips;

  const AsiaSandbox({super.key, required this.trips});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: trips.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return DashboardTile(
            trip: trips[index],
          );
        });
  }
}
