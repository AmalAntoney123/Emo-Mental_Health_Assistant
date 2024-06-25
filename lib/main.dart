// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:emo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation/navigation.dart'; // Import your navigation settings file
import 'theme/theme.dart'; // Import your theme settings
import 'theme/theme_notifier.dart'; // Import your ThemeNotifier

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if the app is launched for the first time
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(isFirstLaunch: isFirstLaunch),
    ),
  );

  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.isDarkMode ? darkTheme : lightTheme,
          initialRoute: isFirstLaunch ? Routes.introScreen : Routes.homeScreen,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
