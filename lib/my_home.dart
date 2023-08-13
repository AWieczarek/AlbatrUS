import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'api_routes.dart';
import 'models/trip.dart';

class MyHome extends StatefulWidget {
  MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? username = user?.displayName;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person),
                              minRadius: 20,
                              maxRadius: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                username!,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () async {
                      logOut(context);
                    },
                    icon: const Icon(Icons.logout),
                    iconSize: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Witaj, ${username}"),
              Text("Kręcący sie ziemniak!"),
              ElevatedButton(
                  onPressed: () async {
                    Trip trip = Trip(country: "Rosja", city: "Moskwa", dateFrom: DateTime.now(), dateTo: DateTime.now(), description: "Dupa dupa dupa", rate: 4);

                    final docTrip = FirebaseFirestore.instance.collection('trips');
                    await docTrip.add(trip.toJson());
                    }, child: Text("Przypierdol albatrosa"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed(AppRoutes.login);
  }
}
