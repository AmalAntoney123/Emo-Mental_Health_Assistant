// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Define your new color palette
const darkPrimaryColor = Color.fromARGB(255, 255, 255, 255);
const darkAccentColor = Color.fromRGBO(38, 43, 55, 1);
const darkButtonColor = Color.fromRGBO(151, 147, 235, 1);
const darkTextColor = Color.fromRGBO(247, 250, 254, 1);

const lightPrimaryColor = Color.fromARGB(255, 0, 0, 0);
const lightAccentColor = Color.fromRGBO(247, 250, 254, 1);
const lightButtonColor = Color.fromRGBO(
    136, 131, 240, 1); // Keep the orange for the button in light theme as well
const lightTextColor = Color.fromRGBO(220, 235, 255, 1);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: lightTextColor),
    bodyMedium: TextStyle(color: lightTextColor),
  ),
  colorScheme: ColorScheme.light(
    primary: lightPrimaryColor,
    secondary: lightAccentColor, // Use lightAccentColor as the secondary color
    background: lightAccentColor,
    onBackground: lightTextColor,
    onPrimary: lightButtonColor,
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
    secondary: darkAccentColor, // Use darkAccentColor as the secondary color
    background: darkAccentColor,
    onBackground: darkTextColor,
    onPrimary: darkButtonColor,
  ).copyWith(background: darkAccentColor),
);
