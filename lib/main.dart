import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/navigation.dart'; // Import your navigation settings file
import 'theme/theme.dart'; // Import your theme settings
import 'theme/theme_notifier.dart'; // Import your ThemeNotifier

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.isDarkMode ? darkTheme : lightTheme,
          initialRoute: Routes.introScreen,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
