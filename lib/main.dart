import 'dart:math';

import 'package:albatrus/custom_routes.dart';
import 'package:albatrus/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black),
        useMaterial3: true,
      ),
      routes: customRoutes,
      initialRoute: FirebaseAuth.instance.currentUser == null ? AppRoutes.login : AppRoutes.home,

    );
  }
}