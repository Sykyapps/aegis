import 'package:aegis/src/styles/color/scheme.dart';
import 'package:flutter/material.dart';

class AegisTheme {
  AegisTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Uni Neue',
    brightness: Brightness.light,
    colorScheme: AegisColorScheme.light,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Uni Neue',
    brightness: Brightness.dark,
    colorScheme: AegisColorScheme.dark,
  );
}
