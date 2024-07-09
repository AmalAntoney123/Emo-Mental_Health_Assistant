// ignore_for_file: prefer_const_constructors

import 'package:emo/utils/navigation.dart';
import 'package:emo/utils/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () => Provider.of<ThemeNotifier>(context, listen: false)
                .toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Emo",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            Spacer(),
            Center(
              child: Image.asset(
                'assets/icon.png', // Ensure your logo is in the assets folder
                width: 100,
                height: 100,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signinScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login, // Replace with the icon you want
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              SizedBox(
                                  width: 10), // Adjust the spacing as needed
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize:
                                      20, // Adjust the font size as needed
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            signInGoogle(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/google-icon.png', // Adjust the path as per your project structure
                                  height: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground // Adjust the size as needed
                                  ),
                              SizedBox(
                                  width: 10), // Adjust the spacing as needed
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize:
                                      20, // Adjust the font size as needed
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.signupScreen);
                    },
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInGoogle(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pop(context); // Remove loading indicator

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          // Check if user data exists
          final databaseReference = FirebaseDatabase.instance.ref();
          final userDataSnapshot = await databaseReference
              .child('users')
              .child(userCredential.user!.uid)
              .get();

          if (userDataSnapshot.exists) {
            // User data exists, go to home screen
            Navigator.pushReplacementNamed(context, Routes.homeScreen);
          } else {
            // User data doesn't exist, go to data collection page
            Navigator.pushReplacementNamed(context, Routes.userDataCollection);
          }
        } else {
          // Email is not verified
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Please verify your email before logging in.')),
          );
          // Optionally, offer to resend verification email
          bool? resend = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              final theme = Theme.of(context);
              return AlertDialog(
                backgroundColor: theme.colorScheme.background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: Text(
                  'Email not verified',
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
                content: Text(
                  'Would you like to resend the verification email?',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'No',
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  ElevatedButton(
                    child: Text('Yes'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme.colorScheme.background,
                      backgroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          );
          if (resend == true) {
            await userCredential.user!.sendEmailVerification();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Verification email sent. Please check your inbox.')),
            );
          }
          // Sign out the user since they haven't verified their email
          await FirebaseAuth.instance.signOut();
        }
      }
    } catch (e) {
      Navigator.pop(context); // Remove loading indicator
      Fluttertoast.showToast(
        msg: 'Sign in failed: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
