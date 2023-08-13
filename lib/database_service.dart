
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/trip.dart';

class DatabaseService{

  static void createTrip(Trip trip) async {
    final docTrip = FirebaseFirestore.instance.collection('trips');
    await docTrip.add(trip.toJson());
  }

  static Future<Stream<List<Trip>>> fetchAllTrips() async {
    final docTrip = FirebaseFirestore.instance.collection('trips');

    return docTrip
        .snapshots()
        .map((event) => event.docs.map((doc) => Trip.fromJson(doc.data())).toList());
  }

}