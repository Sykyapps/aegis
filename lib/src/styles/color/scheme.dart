import 'package:flutter/material.dart';

import 'color.dart';
import 'schemes/dark_color_scheme.dart';
import 'schemes/light_color_scheme.dart';

/// Built based on Material 3 Color Guidelines
///
/// Please refer to the below documentation.
/// https://m3.material.io/styles/color/system/overview
///
class AegisColorScheme {
  AegisColorScheme._();

  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: AegisLightColorScheme.primary,
    onPrimary: AegisLightColorScheme.onPrimary,
    primaryContainer: AegisLightColorScheme.primaryContainer,
    onPrimaryContainer: AegisLightColorScheme.onPrimaryContainer,
    secondary: AegisLightColorScheme.secondary,
    onSecondary: AegisLightColorScheme.onSecondary,
    secondaryContainer: AegisLightColorScheme.secondaryContainer,
    onSecondaryContainer: AegisLightColorScheme.onSecondaryContainer,
    tertiary: AegisLightColorScheme.tertiary,
    onTertiary: AegisLightColorScheme.onTertiary,
    tertiaryContainer: AegisLightColorScheme.tertiaryContainer,
    onTertiaryContainer: AegisLightColorScheme.onTertiaryContainer,
    error: AegisLightColorScheme.error,
    onError: AegisLightColorScheme.onError,
    errorContainer: AegisLightColorScheme.errorContainer,
    onErrorContainer: AegisLightColorScheme.onErrorContainer,
    background: AegisLightColorScheme.background,
    onBackground: AegisLightColorScheme.onBackground,
    surface: AegisLightColorScheme.surface,
    onSurface: AegisLightColorScheme.onSurface,
    surfaceVariant: AegisLightColorScheme.surfaceVariant,
    onSurfaceVariant: AegisLightColorScheme.onSurfaceVariant,
    outline: AegisLightColorScheme.outline,
    outlineVariant: AegisLightColorScheme.outlineVariant,
    inverseSurface: AegisLightColorScheme.inverseSurface,
    onInverseSurface: AegisLightColorScheme.onInverseSurface,
    inversePrimary: AegisLightColorScheme.inversePrimary,
    surfaceTint: AegisColors.transparent,
    shadow: AegisColors.shadow,
    scrim: AegisColors.neutralVariant600,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: AegisDarkColorScheme.primary,
    onPrimary: AegisDarkColorScheme.onPrimary,
    primaryContainer: AegisDarkColorScheme.primaryContainer,
    onPrimaryContainer: AegisDarkColorScheme.onPrimaryContainer,
    secondary: AegisDarkColorScheme.secondary,
    onSecondary: AegisDarkColorScheme.onSecondary,
    secondaryContainer: AegisDarkColorScheme.secondaryContainer,
    onSecondaryContainer: AegisDarkColorScheme.onSecondaryContainer,
    tertiary: AegisDarkColorScheme.tertiary,
    onTertiary: AegisDarkColorScheme.onTertiary,
    tertiaryContainer: AegisDarkColorScheme.tertiaryContainer,
    onTertiaryContainer: AegisDarkColorScheme.onTertiaryContainer,
    error: AegisDarkColorScheme.error,
    onError: AegisDarkColorScheme.onError,
    errorContainer: AegisDarkColorScheme.errorContainer,
    onErrorContainer: AegisDarkColorScheme.onErrorContainer,
    background: AegisDarkColorScheme.background,
    onBackground: AegisDarkColorScheme.onBackground,
    surface: AegisDarkColorScheme.surface,
    onSurface: AegisDarkColorScheme.onSurface,
    surfaceVariant: AegisDarkColorScheme.surfaceVariant,
    onSurfaceVariant: AegisDarkColorScheme.onSurfaceVariant,
    outline: AegisDarkColorScheme.outline,
    outlineVariant: AegisDarkColorScheme.outlineVariant,
    inverseSurface: AegisDarkColorScheme.inverseSurface,
    onInverseSurface: AegisDarkColorScheme.onInverseSurface,
    inversePrimary: AegisDarkColorScheme.inversePrimary,
    surfaceTint: AegisColors.transparent,
    shadow: AegisColors.shadow,
    scrim: AegisColors.neutralVariant600,
  );
}
