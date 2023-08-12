import 'package:albatrus/login/login_page.dart';
import 'package:albatrus/my_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class LoginCodePage extends StatefulWidget {
  const LoginCodePage({Key? key}) : super(key: key);

  @override
  State<LoginCodePage> createState() => _LoginCodePageState();
}

class _LoginCodePageState extends State<LoginCodePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String smsCode = "";

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
                "Oddawaj koda: ",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                androidSmsAutofillMethod: AndroidSmsAutofillMethod
                    .smsRetrieverApi,
                listenForMultipleSmsOnAndroid: true,
                length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onChanged: (value) {
                  smsCode = value;
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
                      PhoneAuthCredential credential = PhoneAuthProvider
                          .credential(
                          verificationId: LoginPage.verify, smsCode: smsCode);
                      await auth.signInWithCredential(credential);

                      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                    child: const Text("Submit"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
