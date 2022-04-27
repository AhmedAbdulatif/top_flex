import 'package:flutter/material.dart';

class MyColors {
  static var primary = const Color(0xffFF8300);
  static var secondary = const Color(0xff262c3a);
  static var dark = const Color(0xFF8D8E98);
  static var darkness = const Color(0xffbdbdbd);
  static var redAccent = const Color(0xffff0059);

  static Map<int, Color> prSwatch = {
    50: const Color(0x1Ae6aa29), //10%
    100: const Color(0x33e6aa29), //20%
    200: const Color(0x4De6aa29), //30%
    300: const Color(0x66e6aa29), //40%
    400: const Color(0x80e6aa29), //50%
    500: const Color(0x99e6aa29), //60%
    600: const Color(0xBFe6aa29), //70%
    700: const Color(0xCCe6aa29), //80%
    800: const Color(0xE6e6aa29), //90%
    900: const Color(0xffe6aa29), //100%
  };

  static Map<int, Color> secSwatch = {
    50: const Color(0x1A262c3a), //10%
    100: const Color(0x33262c3a), //20%
    200: const Color(0x4D262c3a), //30%
    300: const Color(0x66262c3a), //40%
    400: const Color(0x80262c3a), //50%
    500: const Color(0x99262c3a), //60%
    600: const Color(0xBF262c3a), //70%
    700: const Color(0xCC262c3a), //80%
    800: const Color(0xE6262c3a), //90%
    900: const Color(0xff262c3a), //100%
  };
  static Map<int, Color> darkSwatch = {
    50:  const Color(0x1A8D8E98), //10%
    100: const Color(0x338D8E98), //20%
    200: const Color(0x4D8D8E98), //30%
    300: const Color(0x668D8E98), //40%
    400: const Color(0x808D8E98), //50%
    500: const Color(0x998D8E98), //60%
    600: const Color(0xBF8D8E98), //70%
    700: const Color(0xCC8D8E98), //80%
    800: const Color(0xE68D8E98), //90%
    900: const Color(0xFF8D8E98), //100%
  };

  static MaterialColor primaryColor = MaterialColor(0xffe6aa29, prSwatch);
  static MaterialColor secondaryColor = MaterialColor(0xffe6aa29, secSwatch);
  static MaterialColor darkColor = MaterialColor(0xffe6aa29, darkSwatch);
}