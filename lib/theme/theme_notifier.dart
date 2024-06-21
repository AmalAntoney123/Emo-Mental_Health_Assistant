import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeNotifier() {
    _loadDarkModeFromDevice();
    _subscribeToPlatformBrightnessChanges();
  }

  void _loadDarkModeFromDevice() {
    _isDarkMode =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
  }

  void _subscribeToPlatformBrightnessChanges() {
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {
      _loadDarkModeFromDevice();
      notifyListeners();
    };
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
