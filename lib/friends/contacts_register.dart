import 'package:albatrus/api_routes.dart';
import 'package:albatrus/friends/contacts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../database_service.dart';
import '../models/user.dart';
import 'accept_friends_tile.dart';
import 'add_friends_tile.dart';

class ContactsRegister extends StatefulWidget {
  ContactsRegister({Key? key}) : super(key: key);

  @override
  State<ContactsRegister> createState() => _ContactsRegisterState();
}

class _ContactsRegisterState extends State<ContactsRegister> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
       Navigator.of(context).pushNamed(AppRoutes.home);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Contacts(),
      floatingActionButton: ElevatedButton(onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.home);
      }, child: const Text("Next")),
    );
  }
}
