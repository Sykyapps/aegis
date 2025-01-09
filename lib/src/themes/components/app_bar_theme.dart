import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/color/schemes/dark_color_scheme.dart';
import '../../styles/color/schemes/light_color_scheme.dart';
import '../../foundation/typography.dart';

class AegisAppBarTheme {
  const AegisAppBarTheme._();

  static AppBarTheme light = AppBarTheme(
    centerTitle: false,
    backgroundColor: AegisLightColorScheme.background,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: AegisFont.headlineSmall.copyWith(
      color: AegisLightColorScheme.onSurface,
    ),
    iconTheme: const IconThemeData(color: AegisLightColorScheme.onSurface),
  );

  static AppBarTheme dark = AppBarTheme(
    centerTitle: false,
    backgroundColor: AegisDarkColorScheme.background,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: AegisFont.headlineSmall.copyWith(
      color: AegisDarkColorScheme.onBackground,
    ),
    iconTheme: const IconThemeData(color: AegisDarkColorScheme.onBackground),
  );
}
