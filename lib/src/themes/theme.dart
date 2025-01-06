import 'package:flutter/material.dart';

import '../styles/color/scheme.dart';
import '../styles/text/theme.dart';

class AegisTheme {
  AegisTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Uni Neue',
    textTheme: AegisTextTheme.light,
    brightness: Brightness.light,
    colorScheme: AegisColorScheme.light,
    scaffoldBackgroundColor: AegisColorScheme.light.background,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Uni Neue',
    textTheme: AegisTextTheme.dark,
    brightness: Brightness.dark,
    colorScheme: AegisColorScheme.dark,
    scaffoldBackgroundColor: AegisColorScheme.dark.background,
  );
}
