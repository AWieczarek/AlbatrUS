import 'package:albatrus/custom_colors.dart';
import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/user_short.dart';
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
            "AlbatrUs",
            style: TextStyle(color: CustomColors().textColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        drawer: Container(
          width: MediaQuery.of(context).size.width / 5 * 4,
          child: Drawer(
            backgroundColor: CustomColors().backgroundColor,
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
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.person,
                                  size: MediaQuery.of(context).size.width / 10,
                                  color: CustomColors().secondaryTextColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 5 * 2,
                                  child: SizedBox(
                                    width: 200,
                                    child: AutoSizeText(
                                      "username!",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors().textColor),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: CustomColors().myGrayColor),
                      const SizedBox(
                        width: 10.0,
                        height: 20.0,
                      ),
                      ListTile(
                        title: Text(
                          'Settings',
                          style: TextStyle(color: CustomColors().textColor),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.settingsScreen);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Dashboard',
                          style: TextStyle(color: CustomColors().textColor),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.postList);
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
                      color: CustomColors().secondaryTextColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: const MapScreen(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: CustomColors().secondaryTextColor,
                ),
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.of(context).pushNamed(AppRoutes.newTripForm,
                      arguments: Trip(
                          country: "",
                          city: "",
                          dateFrom: DateTime(1969),
                          dateTo: DateTime(1999),
                          description: "w dupe",
                          rate: 2,
                          user: UserShort(userId: "id", username: "user")));
                },
                // Ikona wewnątrz przycisku
                tooltip: 'Add trip',
                child: Icon(Icons.add,
                    color: CustomColors().textColor, size: 30.0),
              ),
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
