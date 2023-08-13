import 'package:albatrus/dashboard/dashboard-tile.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';

void main() {
  runApp(AsiaSandbox());
}

final List<Trip> trips = <Trip>[
  Trip(
      country: "Poland",
      city: "Radom",
      dateFrom: DateTime(2023, 10, 21),
      dateTo: DateTime(2023, 10, 30),
      rate: 5,
      description: 'Bardzo mi się podobało!'),
  Trip(
      country: "Urugwaj",
      city: "Montevideooooooooooo",
      dateFrom: DateTime(2022, 07, 03),
      dateTo: DateTime(2023, 10, 30),
      rate: 5,
      description: 'Bardzo mi się podobało!'),
  Trip(
      country: "Dupa",
      city: "Kupa",
      dateFrom: DateTime(2013, 04, 11),
      dateTo: DateTime(2023, 10, 30),
      rate: 5,
      description: 'Bardzo mi się podobało!'),
  Trip(
      country: "Poland",
      city: "Radom",
      dateFrom: DateTime(2023, 10, 21),
      dateTo: DateTime(2023, 10, 30),
      rate: 5,
      description: 'Bardzo mi się podobało!'),
  Trip(
      country: "Urugwaj",
      city: "Montevideooooooooooo",
      dateFrom: DateTime(2022, 07, 03),
      dateTo: DateTime(2023, 10, 30),
      rate: 5,
      description: 'Bardzo mi się podobało!'),
  Trip(
      country: "Dupa",
      city: "Kupa",
      dateFrom: DateTime(2013, 04, 11),
      dateTo: DateTime(2023, 10, 30),
      rate: 5,
      description: 'Bardzo mi się podobało!'),
];

class AsiaSandbox extends StatelessWidget {
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
