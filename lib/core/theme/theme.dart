import 'package:flutter/material.dart';

const PRIMARY_COLOR = Color(0xFFa6a6a6);
const ACCENT_COLOR = Color(0xffd9d9d9);

ThemeData appTheme = ThemeData(
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
    bodySmall: TextStyle(color: Colors.black45, fontSize: 12),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: PRIMARY_COLOR,
    titleTextStyle: TextStyle(fontSize: 20),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PRIMARY_COLOR, // Default button color
      textStyle: TextStyle(color: Colors.black)
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: PRIMARY_COLOR,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: ACCENT_COLOR,
    selectedItemColor : Colors.black,
  )

  // iconTheme: IconThemeData(
  //   color: Colors.blue, // Default icon color
  // ),
);
