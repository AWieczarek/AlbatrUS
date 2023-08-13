import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'api_routes.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Kręcący sie ziemniak!"),
            ElevatedButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed(AppRoutes.login);
            }, child: Text("Log out"))
          ],
        ),
      ),
    );

  }


}
