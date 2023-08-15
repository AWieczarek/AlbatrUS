import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database_service.dart';
import '../models/user.dart';
import 'accept_friends_tile.dart';
import 'add_friends_tile.dart';

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: Future.wait([getUsersToAccept(user!.uid), getUserLists()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Country Selector Error');
            } else if (snapshot.hasData) {
              List<UserData> userToAccept = snapshot.data![0];
              List<UserData> userTo = snapshot.data![1];
              return Column(
                children: [
                  const Text("Friends to accept: "),
                  Expanded(
                    child: ListView.builder(
                        itemCount: userToAccept.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return AcceptFriendsTile(
                              ownerId: user!.uid, user: userToAccept[index]);
                        }),
                  ),
                  const Text("Friends to accept: "),
                  Expanded(
                    child: ListView.builder(
                        itemCount: userTo.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return AddFriendsTile(
                              ownerId: user!.uid, user: userTo[index]);
                        }),
                  ),
                ],
              );
            } else {
              return const Text("Inconsistant");
            }
          }),
    );
  }

  Future<List<UserData>> getUserLists() async {
    List<UserData> users = await DatabaseService.fetchUsers();
    List<String> usersPhones = users.map((e) => e.phoneNumber).toList();

    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);

    List<String> formattedNumbers = contacts
        .where((e) => e.phones != null)
        .map((e) => e.phones!.first.value)
        .where((e) => e != null)
        .map((e) => e!.replaceAll(' ', ''))
        .where((e) => e.length >= 9)
        .map((e) => e.startsWith("+48") ? e : "+48$e")
        .toList();

    List<String> usersInApp =
        usersPhones.where((e) => formattedNumbers.contains(e)).toList();
    List<UserData> userInAppUsers =
        users.where((e) => usersInApp.contains(e.phoneNumber)).toList();
    print("users in app");
    print(userInAppUsers);
    List<String> myFriends = users
        .where((element) => element.id == user!.uid)
        .toList()
        .first
        .friends;
    userInAppUsers.forEach((element) => print(element.id));
    List<UserData> usersNotInFriends = userInAppUsers
        .where((element) => element.id != user!.uid)
        .where((element) => !myFriends.contains(element.id))
        .toList();
    return usersNotInFriends;
  }

  Future<List<UserData>> getUsersToAccept(String userId) async {
    UserData? fetchUserById = await DatabaseService.fetchUserById(userId);
    List<UserData> fetchUsers =
        await DatabaseService.fetchUsersFromList(fetchUserById!.friendsRequest);
    return fetchUsers;
  }
}
