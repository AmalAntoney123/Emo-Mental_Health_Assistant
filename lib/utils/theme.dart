// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Define your color palette
const darkPrimaryColor = Color.fromARGB(255, 255, 255, 255);
const darkAccentColor = Color.fromRGBO(38, 43, 55, 1);
const darkAccentColor2 = Color.fromRGBO(100, 114, 145, 1);
const darkButtonColor = Color.fromRGBO(151, 147, 235, 1);
const darkTextColor = Color.fromRGBO(247, 250, 254, 1);
const darkPureColor = Color.fromARGB(255, 31, 29, 33);

const lightPrimaryColor = Color.fromARGB(255, 0, 0, 0);
const lightAccentColor = Color.fromRGBO(255, 255, 255, 1);
const lightAccentColor2 = Color.fromRGBO(220, 235, 255, 1);
const lightButtonColor = Color(0xFF8883F0);
const lightTextColor = Color.fromRGBO(220, 235, 255, 1);
const lightPureColor = Colors.white;

// Light theme accent colors
const lightAccent1 = Color.fromARGB(255, 179, 252, 187); // Light blue
const lightAccent2 = Color(0xFF81D4FA); // Medium blue
const lightAccent3 = Color(0xFF4FC3F7); // Darker blue
const lightAccent4 = Color(0xFFAB47BC); // Light purple
const lightAccent5 = Color(0xFF7E57C2); // Dark purple

// Dark theme accent colors
const darkAccent1 = Color.fromARGB(255, 19, 122, 89); // Dark blue
const darkAccent2 = Color(0xFF0277BD); // Darker blue
const darkAccent3 = Color(0xFF01579B); // Deepest blue
const darkAccent4 = Color(0xFF7B1FA2); // Dark purple
const darkAccent5 = Color(0xFF512DA8); // Deeper purple

extension CustomColorScheme on ColorScheme {
  Color get accent1 =>
      brightness == Brightness.light ? lightAccent1 : darkAccent1;
  Color get accent2 =>
      brightness == Brightness.light ? lightAccent2 : darkAccent2;
  Color get accent3 =>
      brightness == Brightness.light ? lightAccent3 : darkAccent3;
  Color get accent4 =>
      brightness == Brightness.light ? lightAccent4 : darkAccent4;
  Color get accent5 =>
      brightness == Brightness.light ? lightAccent5 : darkAccent5;
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: lightTextColor),
    bodyMedium: TextStyle(color: lightTextColor),
  ),
  colorScheme: ColorScheme.light(
    primary: lightPrimaryColor,
    secondary: lightAccentColor2,
    background: lightAccentColor,
    onBackground: lightTextColor,
    onPrimary: lightButtonColor,
    surface: lightPureColor,
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
    secondary: darkAccentColor2,
    background: darkAccentColor,
    onBackground: darkTextColor,
    onPrimary: darkButtonColor,
    surface: darkPureColor,
  ).copyWith(background: darkAccentColor),
);
