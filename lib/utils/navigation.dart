
import 'package:emo/pages/home/home_page.dart';
import 'package:emo/pages/intro/intro_page.dart';
import 'package:emo/pages/login/login_page.dart';
import 'package:emo/pages/login/signin_page.dart';
import 'package:emo/pages/login/signup_page.dart';
import 'package:emo/pages/login/user_data_page.dart';
import 'package:emo/pages/profile/reset_password_page.dart';
import 'package:flutter/material.dart';

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
