import '../color.dart';

/// Built based on Material 3 Color Guidelines
///
/// Please refer to the below documentation.
/// https://m3.material.io/styles/color/system/overview
///
class AegisDarkColorScheme {
  AegisDarkColorScheme._();

  // Primary
  static const primary = AegisColors.purple300;
  static const onPrimary = AegisColors.white;
  static const primaryContainer = AegisColors.darkSurface;
  static const onPrimaryContainer = AegisColors.purple300;

  // Secondary
  static const secondary = AegisColors.backgroundBlack;
  static const onSecondary = AegisColors.white;
  static const secondaryContainer = AegisColors.neutralVariant300;
  static const onSecondaryContainer = AegisColors.white;

  // Tertiary
  static const tertiary = AegisColors.purpleVariant100;
  static const onTertiary = AegisColors.white;
  static const tertiaryContainer = AegisColors.purpleVariant200;
  static const onTertiaryContainer = AegisColors.white;

  // Error
  static const error = AegisColors.red300;
  static const onError = AegisColors.white;
  static const errorContainer = AegisColors.red100;
  static const onErrorContainer = AegisColors.red300;

  // Background
  static const background = AegisColors.backgroundBlack;
  static const onBackground = AegisColors.white;

  // Surface
  static const surface = AegisColors.darkSurface;
  static const onSurface = AegisColors.white;
  static const surfaceVariant = AegisColors.darkSurfaceVariant;
  static const onSurfaceVariant = AegisColors.white;

  // Outline
  static const outline = AegisColors.neutralVariant400;
  static const outlineVariant = AegisColors.neutralVariant500;

  // Inverse
  static const inverseSurface = AegisColors.black;
  static const onInverseSurface = AegisColors.white;
  static const inversePrimary = AegisColors.purple200;
}
