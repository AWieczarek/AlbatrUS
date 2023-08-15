
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/trip.dart';
import 'models/user.dart';

class DatabaseService{

  static Future<void> insertTripWithUserReference(Trip trip) async {
    try {
      CollectionReference tripsCollection = FirebaseFirestore.instance.collection('trips');
      await tripsCollection.add(trip.toJson(),);

      print('Trip inserted with user reference');
    } catch (e) {
      print('Error inserting trip: $e');
    }
  }

  static void createUsername(String id, UserData user) async {
    final docTrip = FirebaseFirestore.instance.collection('users').doc(id);
    await docTrip.set(user.toJson());
  }

  static Future<List<Trip>> fetchTrips() async {
    List<Trip> trips = [];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('trips').get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        trips.add(Trip.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error fetching trips: $e');
    }

    return trips;
  }

  static Future<List<Trip>> fetchTripsByUserId(String userId) async {
    List<Trip> trips = [];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('trips').where('user.userId', isEqualTo: userId).get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        trips.add(Trip.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error fetching trips: $e');
    }

    return trips;
  }

  static Future<UserData?> fetchUserById(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        return UserData.fromJson(userId, userSnapshot.data() as Map<String, dynamic>);
      } else {
        print('User with ID $userId does not exist.');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  static Future<List<UserData>> fetchUsers() async {
    List<UserData> users = [];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        users.add(UserData.fromJson(document.id, document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error fetching trips: $e');
    }

    return users;
  }

  static Future<List<UserData>> fetchUsersWithIdAndPhoneNumber(String id, String phoneNumber) async {
    List<UserData> usersList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: id)
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      querySnapshot.docs.forEach((doc) {
        usersList.add(UserData.fromJson(doc.id, doc.data() as Map<String, dynamic>));
      });
    } catch (e) {
      print("Error fetching users: $e");
    }

    return usersList;
  }

  static Future<List<UserData>> fetchUsersFromList(List<String> userIds) async {
    List<UserData> usersList = [];
    print("dddduppa");
    print(userIds);
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      querySnapshot.docs.forEach((doc) {
        usersList.add(UserData.fromJson(doc.id, doc.data() as Map<String, dynamic>));
      });
    } catch (e) {
      print("Error fetching users: $e");
    }

    return usersList;
  }

  static addFriedRequest() {

  }
  static Future<void> addFriendRequestToUser(String documentId, String elementToAdd) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection("users");

      await collection.doc(documentId).update({
        "friends_requests": FieldValue.arrayUnion([elementToAdd]),
      });
    } catch (e) {
      print("Error adding element to list: $e");
    }
  }

  static Future<void> removeFriendRequestToUser(String documentId, String elementToAdd) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection("users");

      await collection.doc(documentId).update({
        "friends_requests": FieldValue.arrayRemove([elementToAdd]),
      });
    } catch (e) {
      print("Error adding element to list: $e");
    }
  }

  static Future<void> addFriendToAccepted(String documentId, String elementToAdd) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection("users");

      await collection.doc(documentId).update({
        "friends": FieldValue.arrayUnion([elementToAdd]),
      });
    } catch (e) {
      print("Error adding element to list: $e");
    }
  }

  static Future<void> removeFriend(String documentId, String elementToAdd) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection("users");

      await collection.doc(documentId).update({
        "friends": FieldValue.arrayRemove([elementToAdd]),
      });

      await collection.doc(elementToAdd).update({
        "friends": FieldValue.arrayRemove([documentId]),
      });
    } catch (e) {
      print("Error adding element to list: $e");
    }
  }

}