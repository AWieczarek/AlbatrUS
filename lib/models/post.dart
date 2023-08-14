//todo kiedyś posty

// import 'dart:convert';
//
// import 'package:albatrus/models/user_short.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Post postFromJson(String str) => Post.fromJson(json.decode(str));
//
// String postToJson(Post data) => json.encode(data.toJson());
//
// List<UserShort> userShortListFromJson(String str) =>
//     List<UserShort>.from(json.decode(str).map((x) => UserShort.fromJson(x)));
//
// String userShortListToJson(List<UserShort> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Post {
//   UserShort user;
//   String content;
//   DateTime timeStamp;
//   List<UserShort> likedUsers;
//   String tripId;
//
//   Post({
//     required this.user,
//     required this.content,
//     required this.timeStamp,
//     required this.likedUsers,
//     required this.tripId,
//   });
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         user: UserShort.fromJson(json['user']),
//         content: json['content'],
//         timeStamp: (json["timeStamp"] as Timestamp).toDate(),
//         tripId: json['tripId'],
//         likedUsers: userShortListFromJson['likedUsers'],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user": user.toJson(),
//         "content": content,
//         "timeStamp": Timestamp.fromDate(timeStamp),
//         "tripId": tripId,
//         "likedUsers": likedUsers,
//       };
//
//   @override
//   String toString() {
//     return 'Post{user: $user, content: $content, timeStamp: $timeStamp, likedUsers: ${likedUsers.toString()}, description: $description, rate: $rate, user: $user}';
//   }
// }
