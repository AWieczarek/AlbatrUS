import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TripUser userFromJson(String str) => TripUser.fromJson(json.decode(str));

String userToJson(TripUser data) => json.encode(data.toJson());

class TripUser {
  String userId;
  String username;

  TripUser({
    required this.userId,
    required this.username,
  });

  factory TripUser.fromJson(Map<String, dynamic> json) => TripUser(
    userId: json["userId"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
  };

  @override
  String toString() {
    return 'TripUser{userId: $userId, username: $username}';
  }
}