import 'package:flutter/material.dart';

import '../styles/color/scheme.dart';

class AegisTheme {
  AegisTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Uni Neue',
    brightness: Brightness.light,
    colorScheme: AegisColorScheme.light,
    scaffoldBackgroundColor: AegisColorScheme.light.background,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Uni Neue',
    brightness: Brightness.dark,
    colorScheme: AegisColorScheme.dark,
    scaffoldBackgroundColor: AegisColorScheme.dark.background,
  );
}
