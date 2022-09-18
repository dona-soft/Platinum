import 'package:flutter/material.dart';

class LightTheme {
  static var primaryColorLight = const Color(0xffc14e00);
  static var secondaryColorLight = const Color(0xffEFF2F7);
}

var lightTheme = ThemeData(
  primarySwatch: const MaterialColor(
    500,
    {
      100: Color(0xffc14e00),
    },
  ),
);
