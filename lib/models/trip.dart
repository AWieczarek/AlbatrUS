import 'dart:convert';

Trip tripFromJson(String str) => Trip.fromJson(json.decode(str));

String tripToJson(Trip data) => json.encode(data.toJson());

class Trip {
  String country;
  String city;
  DateTime dateFrom;
  DateTime dateTo;
  String description;
  int rate;

  Trip({
    required this.country,
    required this.city,
    required this.dateFrom,
    required this.dateTo,
    required this.description,
    required this.rate,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    country: json["country"],
    city: json["city"],
    dateFrom: DateTime.parse(json["date_from"]),
    dateTo: DateTime.parse(json["date_to"]),
    description: json["description"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "city": city,
    "date_from": dateFrom.toIso8601String(),
    "date_to": dateTo.toIso8601String(),
    "description": description,
    "rate": rate,
  };
}