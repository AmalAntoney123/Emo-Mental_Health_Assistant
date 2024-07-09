// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emo/theme/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emo/navigation/navigation.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int failedAttempts = 0;

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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _login(context),
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
                                Icons.login,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
                  if (failedAttempts >= 1)
                    GestureDetector(
                      onTap: () {
                        // Navigate to reset password screen
                        Navigator.pushNamed(
                            context, Routes.resetPasswordScreen);
                      },
                      child: Text(
                        'Forgot Password? Reset Here',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  SizedBox(height: 40),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    // Check if any of the fields are empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If we get here, sign in was successful
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          // Email is verified, proceed to home screen
          Navigator.pushReplacementNamed(context, Routes.userDataCollection);
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme.colorScheme.background,
                      backgroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'),
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
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided.';
      } else {
        message = 'An error occurred. Please try again: ${e.code}';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

      setState(() {
        failedAttempts++;
      });
    }
  }
}
