import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNumber = "";
  bool _isLoading = false;

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
                "Dawaj numera, śmierdziela:",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              IntlPhoneField(
                flagsButtonPadding: const EdgeInsets.all(8),
                dropdownIconPosition: IconPosition.trailing,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                initialCountryCode: 'PL',
                onChanged: (phone) {
                  print(phone.completeNumber);
                  print(phone.countryCode);
                  phoneNumber = phone.completeNumber;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneNumber,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          LoginPage.verify = verificationId;
                          Navigator.of(context).pushNamed('/login/code');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator() // Show loading indicator while isLoading is true
                        : Text('Send Code'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


