import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Consider to changes its class name to be AegisTextStyle?
/// Also its file name to text_styles.dart
class AegisFont {
  /// # Aegis Text Theme
  /// ---
  /// Available text styles:
  /// - Headline Large
  /// - Headline Medium
  /// - Headline Small
  /// - Body Large
  /// - Body Medium
  /// - Body Small
  /// - Small
  ///
  /// ## Usage
  /// ---
  ///
  /// ```dart
  /// ThemeData theme = Theme.of(context).copyWith(
  ///   textTheme: AegisFont.textTheme,
  /// );
  /// ```
  static TextTheme textTheme = TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  );

  /// # Headline Large
  /// ---
  /// - Font Family: Uni Neue
  /// - Font Size: 32
  /// - Line Height: 48
  /// - FontWeight: 700
  ///
  /// ## Usage
  /// ---
  /// Oversized screen title use only once per page
  /// ```dart
  /// Text text = Text(
  ///   'text',
  ///   style: AegisFont.headlineLarge.copyWith(
  ///     color: Colors.black,
  ///   ),
  /// );
  /// ```
  static TextStyle headlineLarge = TextStyle(
    fontFamily: 'Uni Neue',
    fontSize: 32.sp,
    height: 48 / 32,
    fontWeight: FontWeight.w700,
  );

  /// # Headline Medium
  /// ---
  /// - Font Family: Uni Neue
  /// - Font Size: 24
  /// - Line Height: 36
  /// - Font Weight: 700
  ///
  /// ## Usage
  /// ---
  /// Main title, use only once per page
  /// ```dart
  /// Text text = Text(
  ///   'text',
  ///   style: AegisFont.headlineMedium.copyWith(
  ///     color: Colors.black,
  ///   ),
  /// );
  /// ```
  static TextStyle headlineMedium = TextStyle(
    fontFamily: 'Uni Neue',
    fontSize: 24.sp,
    height: 36 / 24,
    fontWeight: FontWeight.w700,
  );

  /// # Headline Small
  /// ---
  /// - Font Family: Uni Neue
  /// - Font Size: 20
  /// - Line Height: 24
  /// - Font Weight: 700
  ///
  /// ## Usage
  /// ---
  /// Section Title/ Heading up a group of list items
  /// ```dart
  /// Text text = Text(
  ///   'text',
  ///   style: AegisFont.headlineSmall.copyWith(
  ///     color: Colors.black,
  ///   ),
  /// );
  /// ```
  static TextStyle headlineSmall = TextStyle(
    fontFamily: 'Uni Neue',
    fontSize: 20.sp,
    height: 24 / 20,
    fontWeight: FontWeight.w700,
  );

  /// # Body Large
  /// ---
  /// - Font Family: Uni Neue
  /// - Font Size: 16
  /// - Line Height: 22
  /// - Font Weight: 500
  ///
  /// ## Usage
  /// ---
  /// Sub Heading, Large Button, Link
  /// ```dart
  /// Text text = Text(
  ///   'text',
  ///   style: AegisFont.bodyLarge.copyWith(
  ///     color: Colors.black,
  ///   ),
  /// );
  /// ```
  static TextStyle bodyLarge = TextStyle(
    fontFamily: 'Uni Neue',
    fontSize: 16.sp,
    height: 22 / 16,
    fontWeight: FontWeight.w500,
  );

  /// # Body Medium
  /// ---
  /// - Font Family: Uni Neue
  /// - Font Size: 14
  /// - Line Height: 20
  /// - Font Weight: 500
  ///
  /// ## Usage
  /// ---
  /// Body Copy, Medium Button, Link, Text Field
  /// ```dart
  /// Text text = Text(
  ///   'text',
  ///   style: AegisFont.bodyMedium.copyWith(
  ///     color: Colors.black,
  ///   ),
  /// );
  /// ```
  static TextStyle bodyMedium = TextStyle(
    fontFamily: 'Uni Neue',
    fontSize: 14.sp,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
  );

  /// # Body Small
  /// ---
  /// - Font Family: Uni Neue
  /// - Font Size: 12
  /// - Line Height: 16
  /// - Font Weight: 500
  ///
  /// ## Usage
  /// ---
  /// Caption, Small Button, Helper, Label on text field
  /// ```dart
  /// Text text = Text(
  ///   'text',
  ///   style: AegisFont.bodySmall.copyWith(
  ///     color: Colors.black,
  ///   ),
  /// );
  /// ```
  static TextStyle bodySmall = TextStyle(
    fontFamily: 'Uni Neue',
    fontSize: 12.sp,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
  );

  /// # Small
  /// ---
  /// - Font Family: Uni Neue
  /// - Font Size: 10
  /// - Line Height: 14
  /// - Font Weight: 500
  ///
  /// ## Usage
  /// ---
  /// Small Information, Label
  /// ```dart
  /// Text text = Text(
  ///   'text',
  ///   style: AegisFont.small.copyWith(
  ///     color: Colors.black,
  ///   ),
  /// );
  /// ```
  static TextStyle small = TextStyle(
    fontFamily: 'Uni Neue',
    fontSize: 10.sp,
    height: 14 / 10,
    fontWeight: FontWeight.w500,
  );
}
