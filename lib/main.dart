import 'package:emo/utils/navigation.dart';
import 'package:emo/utils/theme.dart';
import 'package:emo/utils/theme_notifier.dart';
import 'package:emo/pages/home/home_page.dart';
import 'package:emo/pages/intro/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emo/services/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
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
                return const Center(
                    child: CircularProgressIndicator()); // Or a splash screen
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
