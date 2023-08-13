
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

}