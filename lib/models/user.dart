import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// UserData userFromJson(String str) => UserData.fromJson(json.decode(str));

String userToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String id;
  String username;
  DateTime creationDate;

  UserData({
    required this.id,
    required this.username,
    required this.creationDate,
  });

  factory UserData.fromJson(String id, Map<String, dynamic> json) => UserData(
    id: id,
    username: json["username"],
    creationDate: (json["creation_date"] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "creation_date": creationDate.toIso8601String(),
  };

  @override
  String toString() {
    return 'UserData{id: $id, username: $username, creationDate: $creationDate}';
  }
}