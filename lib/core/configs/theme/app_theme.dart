import 'package:flutter/material.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackGround,
    fontFamily: 'Satoshi',
    brightness: Brightness.light, //lightness or darkness of our theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(30),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black, width: 0.4),
      ),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black, width: 0.4),
      ),
      hintStyle: const TextStyle(
        color: Color(0xff383838),
        fontWeight: FontWeight.w500
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(30),
        ),
      ),
    ),
  );
  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackGround,
    fontFamily: 'Satoshi',
    brightness: Brightness.dark, //lightness or darkness of our theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(30),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 0.4),
      ),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 0.4),
      ),
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w500
      ),
      
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(30),
        ),
      ),
    ),
  );
}
