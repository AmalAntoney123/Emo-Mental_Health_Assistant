import 'package:emo/home_page.dart';
import 'package:emo/signin_page.dart';
import 'package:emo/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:emo/login_page.dart'; // Import your login page
import 'package:emo/intro_page.dart'; // Import your intro screen

class Routes {
  static const String introScreen = '/';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String signinScreen = '/signin';
  static const String homeScreen = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case introScreen:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case signinScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('ERROR: Page not found'),
        ),
      );
    });
  }
}
