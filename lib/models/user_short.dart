import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserShort userFromJson(String str) => UserShort.fromJson(json.decode(str));

String userToJson(UserShort data) => json.encode(data.toJson());

class UserShort {
  String userId;
  String username;

  UserShort({
    required this.userId,
    required this.username,
  });

  factory UserShort.fromJson(Map<String, dynamic> json) => UserShort(
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