import 'package:flutter/material.dart';
import 'package:emo/login_page.dart'; // Import your login page
import 'package:emo/intro_page.dart'; // Import your intro screen

class Routes {
  static const String introScreen = '/';
  static const String loginScreen = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case introScreen:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
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
