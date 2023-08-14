import 'package:albatrus/dashboard/asia_sandbox.dart';
import 'package:albatrus/dashboard/dashboard-tile.dart';
import 'package:albatrus/dashboard/post_list.dart';
import 'package:albatrus/friends/contacts_add.dart';
import 'package:albatrus/login/login_code_page.dart';
import 'package:albatrus/login/login_username_page.dart';
import 'package:albatrus/my_friends.dart';
import 'package:albatrus/my_home.dart';
import 'package:albatrus/new_trip_form/new_trip_form.dart';
import 'package:albatrus/settings/settings_screen.dart';
import 'package:albatrus/trip-details/details.dart';
import 'package:flutter/material.dart';

import 'api_routes.dart';
import 'friends/contacts.dart';
import 'friends/contacts_register.dart';
import 'login/login_page.dart';
import 'map_screen.dart';
import 'models/trip.dart';

var customRoutes = <String, WidgetBuilder>{
  AppRoutes.login: (_) => const LoginPage(),
  AppRoutes.loginCode: (_) => const LoginCodePage(),
  AppRoutes.loginUsername: (_) => const LoginUsernamePage(),
  AppRoutes.home: (_) => MyHome(),
  AppRoutes.newTripForm: (context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is Trip) {
      return NewTripForm(tripData: args,);
    }else{
      return ErrorRoute();
    }
  },
  AppRoutes.maps: (_) => MapScreen(),
  AppRoutes.newTripForm: (_) => NewTripForm(),
  AppRoutes.settingsScreen: (_) => const SettingsScreen(),
  AppRoutes.postList: (_) => PostList(),
  AppRoutes.postDetails: (context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is Trip) {
      return Details(trip: args,);
    }else{
      return ErrorRoute();
    }
  },
  AppRoutes.contacts: (_) => ContactsAdd(),
  AppRoutes.contactsRegister: (_) => ContactsRegister(),
  AppRoutes.myFriends: (_) => MyFriends(),

};

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'ERROR',
          ),
        ),
        body: Center(
          child: Text(
              'Błąd wczytywania strony'), // ToDo: think about better screen
        ));
  }
}
