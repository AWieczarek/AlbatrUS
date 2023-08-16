import 'package:albatrus/login/login_page.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
                androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsRetrieverApi,
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
                  onPressed: _isLoading
                      ? null
                      : () async {
                    setState(() => _isLoading = true);
                    try {
                      PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                          verificationId: LoginPage.verify,
                          smsCode: smsCode);
                      var userCredential = await auth.signInWithCredential(credential);
                      if(context.mounted){ // I don't know, flutter required it to navigate after await correctly
                        if(userCredential.additionalUserInfo == null ||
                            userCredential.additionalUserInfo!.isNewUser||
                        userCredential.user!.displayName == null){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login/username", (route) => false);
                        }else{
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/home", (route) => false);
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage =
                          'An error occurred. Please try again.';
                      if (e.code == 'invalid-phone-number') {
                        errorMessage = 'Invalid phone number format';
                      } else if (e.code == 'too-many-requests') {
                        errorMessage =
                        'Too many requests. Please try again later.';
                        // Implement a retry mechanism here if needed
                      } else if (e.code == 'user-disabled') {
                        errorMessage = 'This phone number is disabled.';
                      }
                      _showErrorSnackBar(errorMessage);
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
                      ? CircularProgressIndicator() // Show loading indicator while isLoading is true
                      : Text('Login in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
