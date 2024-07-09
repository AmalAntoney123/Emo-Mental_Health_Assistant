import 'package:emo/firebase_options.dart';
import 'package:emo/user_data_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation/navigation.dart';
import 'theme/theme.dart';
import 'theme/theme_notifier.dart';
import 'home_page.dart';
import 'intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.isDarkMode ? darkTheme : lightTheme,
          home: FutureBuilder<bool>(
            future: checkFirstLaunch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Or a splash screen
              } else {
                final bool isFirstLaunch = snapshot.data ?? true;
                return isFirstLaunch ? IntroScreen() : HomeScreen();
              }
            },
          ),
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }

  Future<bool> checkFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }
    return isFirstLaunch;
  }
}
