import 'package:albatrus/friends/contacts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_colors.dart';
import '../database_service.dart';
import '../models/user.dart';
import 'accept_friends_tile.dart';
import 'add_friends_tile.dart';

class ContactsAdd extends StatelessWidget {
  ContactsAdd({Key? key}) : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors().backgroundColor,
      ),
      body: Contacts(),
      backgroundColor: CustomColors().backgroundColor,
    );
  }
}
