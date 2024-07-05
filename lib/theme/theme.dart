// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Define your new color palette
const darkPrimaryColor = Color.fromARGB(255, 255, 255, 255);
const darkAccentColor = Color.fromRGBO(38, 43, 55, 1);
const darkButtonColor = Color.fromRGBO(151, 147, 235, 1);
const darkTextColor = Color.fromRGBO(247, 250, 254, 1);
const darkPureColor = Colors.black; // New pure black color for dark mode

const lightPrimaryColor = Color.fromARGB(255, 0, 0, 0);
const lightAccentColor = Color.fromRGBO(247, 250, 254, 1);
const lightButtonColor = Color.fromRGBO(136, 131, 240, 1);
const lightTextColor = Color.fromRGBO(220, 235, 255, 1);
const lightPureColor = Colors.white; // New pure white color for light mode

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: lightTextColor),
    bodyMedium: TextStyle(color: lightTextColor),
  ),
  colorScheme: ColorScheme.light(
    primary: lightPrimaryColor,
    secondary: lightAccentColor,
    background: lightAccentColor,
    onBackground: lightTextColor,
    onPrimary: lightButtonColor,
    surface: lightPureColor, // Add the pure white color to the light theme
  ).copyWith(background: lightAccentColor),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimaryColor,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: darkTextColor),
    bodyMedium: TextStyle(color: darkTextColor),
  ),
  colorScheme: ColorScheme.dark(
    primary: darkPrimaryColor,
    secondary: darkAccentColor,
    background: darkAccentColor,
    onBackground: darkTextColor,
    onPrimary: darkButtonColor,
    surface: darkPureColor, // Add the pure black color to the dark theme
  ).copyWith(background: darkAccentColor),
);
