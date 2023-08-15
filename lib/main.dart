import 'dart:async';

import 'package:albatrus/custom_colors.dart';
import 'package:albatrus/custom_routes.dart';
import 'package:albatrus/my_home.dart';
import 'package:albatrus/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(foregroundColor: CustomColors().secondaryTextColor),
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors().myGrayColor),
      ),
      routes: customRoutes,
      navigatorKey: navigatorKey,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AppRoutes.login
          : AppRoutes.home,
      home: MyHome(),
    );
  }
}
