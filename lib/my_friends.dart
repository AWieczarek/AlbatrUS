import 'package:albatrus/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFriends extends StatefulWidget {
  MyFriends({Key? key}) : super(key: key);

  @override
  State<MyFriends> createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: DatabaseService.fetchUserById(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Country Selector Error');
            } else if (snapshot.hasData) {
              return FutureBuilder(
                  future: DatabaseService.fetchUsersFromList(snapshot.data!.friends),
                  builder: (context, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot2.hasError) {
                      return const Text('Country Selector Error');
                    } else if (snapshot2.hasData) {
                      return Column(
                        children: [
                          const Text("Friends: "),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.friends.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ListTile(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot2.data![index].username),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await DatabaseService
                                                .removeFriend(
                                                user!.uid, snapshot.data!.friends[index]);
                                            setState(() {

                                            });
                                          },
                                          child: const Text("Remove"),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return const Text("Inconsistant");
                    }
                  });
            } else {
              return const Text("Inconsistant");
            }
          }),
    );
  }
}
