import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/trip_user.dart';
import 'package:albatrus/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'api_routes.dart';
import 'map_screen.dart';
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(
         "Dupa",
          style: TextStyle(color: Colors.black),
        ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,),
        extendBodyBehindAppBar: true,
        drawer: Container(
          width: MediaQuery.of(context).size.width / 5 * 4,
          child: Drawer(
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
                                minRadius: 20,
                                maxRadius: 30,
                                child: Icon(
                                  Icons.person,
                                  size: MediaQuery.of(context).size.width/10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 5 *2,
                                  child: SizedBox(
                                    width: 200,
                                    child: AutoSizeText(
                                      username!,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Settings'),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.settingsScreen);
                        },
                      ),
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
        ),
        body: MapScreen(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pushNamed(AppRoutes.postList);

            },child: Text('cokolwiek')),
            FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.of(context).pushNamed(AppRoutes.newTripForm);
              }, // Ikona wewnątrz przycisku
              tooltip: 'Add trip',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pushNamed(AppRoutes.login);
    }
  }
}
