import 'package:emo/home_page.dart';
import 'package:emo/reset_password_page.dart';
import 'package:emo/signin_page.dart';
import 'package:emo/signup_page.dart';
import 'package:emo/user_data_page.dart';
import 'package:flutter/material.dart';
import 'package:emo/login_page.dart'; // Import your login page
import 'package:emo/intro_page.dart'; // Import your intro screen

class Routes {
  static const String introScreen = '/';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String signinScreen = '/signin';
  static const String homeScreen = '/home';
  static const String resetPasswordScreen = '/reset_password';
  static const String userDataCollection = '/user_data_collection';

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
      case resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case userDataCollection:
        return MaterialPageRoute(builder: (_) => UserDataCollection());
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
