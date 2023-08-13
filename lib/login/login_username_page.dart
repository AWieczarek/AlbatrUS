import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginUsernamePage extends StatefulWidget {
  const LoginUsernamePage({Key? key}) : super(key: key);

  @override
  State<LoginUsernamePage> createState() => _LoginUsernamePageState();
}

class _LoginUsernamePageState extends State<LoginUsernamePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String name = "";
  bool _isLoading = false;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Jak cię zwą:",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.black), // Customize the color here
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() => _isLoading = true);
                          try {
                            await auth.currentUser!.updateDisplayName(name);
                            var uid2 = auth.currentUser!.uid;
                            UserData user = UserData(
                                id: uid2,
                                username: name,
                                creationDate: DateTime.now());
                            DatabaseService.createUsername(uid2, user);

                            if (context.mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/home", (route) => false);
                            }
                          } catch (e) {
                            _showErrorSnackBar(
                                'An unexpected error occurred. Please try again.');
                          } finally {
                            setState(() => _isLoading = false);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
