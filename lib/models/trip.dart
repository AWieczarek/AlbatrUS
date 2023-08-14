import 'dart:convert';

import 'package:albatrus/models/user_short.dart';
import 'package:albatrus/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Trip tripFromJson(String str) => Trip.fromJson(json.decode(str));

String tripToJson(Trip data) => json.encode(data.toJson());

class Trip {
  String country;
  String city;
  DateTime dateFrom;
  DateTime dateTo;
  String description;
  int rate;
  UserShort user;

  Trip({
    required this.country,
    required this.city,
    required this.dateFrom,
    required this.dateTo,
    required this.description,
    required this.rate,
    required this.user,
  });

  factory Trip.fromJson(Map<String, dynamic> json) =>
      Trip(
        country: json["country"],
        city: json["city"],
        dateFrom: (json["date_from"] as Timestamp).toDate(),
        dateTo: (json["date_to"] as Timestamp).toDate(),
        description: json["description"],
        rate: json["rate"],
        user: UserShort.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
        "date_from": Timestamp.fromDate(dateFrom),
        "date_to": Timestamp.fromDate(dateTo),
        "description": description,
        "rate": rate,
        "user": user.toJson(),
      };

  @override
  String toString() {
    return 'Trip{country: $country, city: $city, dateFrom: $dateFrom, dateTo: $dateTo, description: $description, rate: $rate, user: $user}';
  }
}