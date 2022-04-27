import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';

final lightTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: MyColors.primary),
    ),
    hintStyle: GoogleFonts.cairo(
      textStyle: TextStyle(
        color: MyColors.dark,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.cairo(
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: MyColors.secondary,
      ),
    ),
  ),
  primarySwatch: MyColors.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
    titleTextStyle: GoogleFonts.kufam(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MyColors.primary,
      ),
    ),
    iconTheme: IconThemeData(
      color: MyColors.secondary,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyColors.primary,
    unselectedItemColor: MyColors.dark,
    elevation: 20,
    backgroundColor: Colors.white,
    selectedLabelStyle: GoogleFonts.cairo(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    unselectedLabelStyle: GoogleFonts.cairo(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: MyColors.primary,
      ),
    ),
    hintStyle: GoogleFonts.cairo(
      textStyle: TextStyle(
        color: Colors.white.withOpacity(0.7),
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: MyColors.secondaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColors.secondary,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: MyColors.secondary,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
    titleTextStyle: GoogleFonts.kufam(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: MyColors.primary,
        fontSize: 20,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white.withOpacity(0.7),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyColors.primary,
    unselectedItemColor: Colors.white.withOpacity(0.6),
    elevation: 20,
    backgroundColor: MyColors.secondary,
    selectedLabelStyle: GoogleFonts.cairo(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    unselectedLabelStyle: GoogleFonts.cairo(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.cairo(
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white.withOpacity(0.9),
      ),
    ),
    bodyText2: GoogleFonts.cairo(
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  ),
);
