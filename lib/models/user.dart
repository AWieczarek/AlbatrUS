import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// UserData userFromJson(String str) => UserData.fromJson(json.decode(str));

String userToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String id;
  String username;
  String phoneNumber;
  DateTime creationDate;
  List<String> friends;
  List<String> friendsRequest;

  UserData({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.creationDate,
    required this.friends,
    required this.friendsRequest,
  });

  factory UserData.fromJson(String id, Map<String, dynamic> json) => UserData(
    id: id,
    username: json["username"],
    phoneNumber: json["phone_number"],
    creationDate: (json["creation_date"] as Timestamp).toDate(),
    friends: List<String>.from(json["friends"]),
    friendsRequest: List<String>.from(json["friends_requests"]),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "phone_number": phoneNumber,
    "creation_date": Timestamp.fromDate(creationDate),
    "friends": friends,
    "friends_request": friendsRequest
  };

  @override
  String toString() {
    return 'UserData{id: $id, username: $username, phoneNumber: $phoneNumber, creationDate: $creationDate, friends: $friends, friendsRequest: $friendsRequest}';
  }
}