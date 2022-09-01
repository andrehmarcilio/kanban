import 'package:flutter/material.dart';

final appLightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
        primary: Colors.grey.shade900,
        secondary: Colors.amberAccent.shade200),
    dividerTheme: const DividerThemeData(thickness: 1.4),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(
          fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black),
      headlineMedium: TextStyle(
          fontSize: 35, fontWeight: FontWeight.w500, color: Colors.black),
      displayLarge: TextStyle(
          fontSize: 70, fontWeight: FontWeight.w300, color: Colors.black),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 8, fontWeight: FontWeight.w400, color: Colors.white),
      
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.5)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(20.0)),
      shape: MaterialStateProperty.all(const CircleBorder()),
    )),
    listTileTheme: const ListTileThemeData(textColor: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade900,
        selectedItemColor: Colors.amberAccent.shade200,
        unselectedItemColor: Colors.white));
