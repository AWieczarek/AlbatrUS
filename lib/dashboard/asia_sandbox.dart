import 'package:albatrus/dashboard/dashboard-tile.dart';
import 'package:albatrus/models/user_short.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';



// final List<Trip> trips = <Trip>[
//   Trip(
//       country: "Poland",
//       city: "Radom",
//       dateFrom: DateTime(2023, 10, 21),
//       dateTo: DateTime(2023, 10, 30),
//       rate: 5,
//       description: 'Bardzo mi się podobało!',
//       user:
//           TripUser(userId: "cNHEkw0ea4hC1OzaTtrhcggSpYB2", username: 'kuppa')),
//   Trip(
//       country: "Urugwaj",
//       city: "Montevideooooooooooo",
//       dateFrom: DateTime(2022, 07, 03),
//       dateTo: DateTime(2023, 10, 30),
//       rate: 5,
//       description: 'Bardzo mi się podobało!',
//       user:
//           TripUser(userId: "cNHEkw0ea4hC1OzaTtrhcggSpYB2", username: 'kuppa')),
//   Trip(
//       country: "Dupa",
//       city: "Kupa",
//       dateFrom: DateTime(2013, 04, 11),
//       dateTo: DateTime(2023, 10, 30),
//       rate: 5,
//       description: 'Bardzo mi się podobało!',
//       user:
//           TripUser(userId: "cNHEkw0ea4hC1OzaTtrhcggSpYB2", username: 'kuppa')),
//   Trip(
//       country: "Poland",
//       city: "Radom",
//       dateFrom: DateTime(2023, 10, 21),
//       dateTo: DateTime(2023, 10, 30),
//       rate: 5,
//       description: 'Bardzo mi się podobało!',
//       user:
//           TripUser(userId: "cNHEkw0ea4hC1OzaTtrhcggSpYB2", username: 'kuppa')),
//   Trip(
//       country: "Urugwaj",
//       city: "Montevideooooooooooo",
//       dateFrom: DateTime(2022, 07, 03),
//       dateTo: DateTime(2023, 10, 30),
//       rate: 5,
//       description: 'Bardzo mi się podobało!',
//       user:
//           TripUser(userId: "cNHEkw0ea4hC1OzaTtrhcggSpYB2", username: 'kuppa')),
//   Trip(
//       country: "Dupa",
//       city: "Kupa",
//       dateFrom: DateTime(2013, 04, 11),
//       dateTo: DateTime(2023, 10, 30),
//       rate: 5,
//       description: 'Bardzo mi się podobało!',
//       user:
//           TripUser(userId: "cNHEkw0ea4hC1OzaTtrhcggSpYB2", username: 'kuppa')),
// ];

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
