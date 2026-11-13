import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

/// Standard Aegis modal bottom sheet.
///
/// [child] is rendered inside a white sheet with a drag handle and an
/// optional header ([showHeader]). Use [bottomBar] for CTAs that should
/// not scroll with the content.
///
/// The sheet's result can be passed via `Navigator.pop(value)`; [show]
/// returns a `Future<T?>`.
class SkBottomSheet<T> extends StatelessWidget {
  const SkBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.titleTextStyle,
    this.actions,
    this.bottomBar,
    this.leading,
    this.onClose,
    this.showHeader = true,
    this.showHandle = true,
    this.showCloseButton = true,
    this.hasBottomNav = false,
    this.useSafeArea = true,
    this.bottomInset,
    this.bottomSpacing = 16,
    this.padding,
    this.barrierColor,
    this.backgroundColor = AegisColors.backgroundWhite,
    this.handleColor = AegisColors.backgroundWhite,
    @Deprecated('No longer used; use [showHeader] instead.')
    this.expandedHeight = 100,
    @Deprecated('No longer used.') this.backgroundImage,
  });

  /// The main content of the sheet.
  final Widget child;

  /// Title shown in the header. Required when [showHeader] is enabled.
  final String? title;

  /// Subtitle below [title].
  final String? subtitle;

  /// Overrides the header title style.
  final TextStyle? titleTextStyle;

  /// Actions on the right side of the header.
  final List<Widget>? actions;

  /// Widget rendered below the scrollable area and above the safe area,
  /// e.g. a save button. It does not scroll with the content.
  final Widget? bottomBar;

  /// Overrides the header leading widget (default: close button).
  final Widget? leading;

  /// Action when the close button is pressed (default: `Navigator.maybePop`).
  final VoidCallback? onClose;

  /// Whether to show the header ([SkSliverAppBar]). Set to `false` for a
  /// sheet without a header, e.g. a dialog sheet with an illustration.
  final bool showHeader;

  /// Whether to show the small drag handle at the top of the sheet.
  final bool showHandle;

  /// Whether to show the close button in the header. Ignored when
  /// [leading] is provided.
  final bool showCloseButton;

  /// Reduces the sheet's max height by the height of the bottom
  /// navigation bar.
  final bool hasBottomNav;

  /// Adds bottom padding equal to the device safe area. Defaults to `true`
  /// so content is not covered by the home indicator.
  final bool useSafeArea;

  /// Overrides the bottom padding. When provided, [useSafeArea] is ignored.
  final double? bottomInset;

  /// Extra space below the content or [bottomBar], added on top of the system
  /// safe area. Defaults to 16. Set to `0` when the bottom bar already
  /// provides its own bottom padding.
  final double bottomSpacing;

  /// Content padding. Defaults to no padding so consumers are free to
  /// manage their own content spacing.
  final EdgeInsetsGeometry? padding;

  /// Barrier color. Defaults to [AegisColors.scrim].
  final Color? barrierColor;

  /// The sheet's background color.
  final Color backgroundColor;

  /// The drag handle's color.
  final Color handleColor;

  @Deprecated('No longer used; use [showHeader] instead.')
  final double expandedHeight;

  @Deprecated('No longer used.')
  final ImageProvider<Object>? backgroundImage;

  /// Shows the sheet as a modal route.
  ///
  /// [useRootNavigator] defaults to `true` to preserve legacy behavior;
  /// set it to `true` when the sheet must appear above the bottom
  /// navigation / nested navigator.
  /// [barrierDismissible] `false` also disables drag-to-dismiss.
  Future<T?> show(
    BuildContext context, {
    bool useRootNavigator = true,
    bool barrierDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    String? barrierLabel,
  }) {
    var mediaQuery = MediaQuery.of(context);
    var maxHeight = mediaQuery.size.height - mediaQuery.viewPadding.top;
    if (hasBottomNav) {
      maxHeight -= kBottomNavigationBarHeight + mediaQuery.viewPadding.bottom;
    }

    return showModalBottomSheet<T>(
      context: context,
      constraints: BoxConstraints(maxHeight: maxHeight),
      backgroundColor: AegisColors.transparent,
      barrierColor: barrierColor ?? AegisColors.scrim,
      isDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      enableDrag: barrierDismissible && enableDrag,
      isScrollControlled: true,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      useSafeArea: useSafeArea,
      builder: (context) => this,
    );
  }

  /// Shows a dialog-style sheet: no header, 20dp horizontal padding, shown
  /// on the root navigator and not draggable. It is the replacement for the
  /// deprecated `SkBasicBottomSheet`.
  static Future<T?> showAsDialog<T>(
    BuildContext context, {
    required Widget child,
    EdgeInsetsGeometry? padding,
    bool useRootNavigator = true,
    bool barrierDismissible = true,
  }) {
    return SkBottomSheet<T>(
      showHeader: false,
      showHandle: false,
      bottomInset: 0,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.r),
      child: child,
    ).show(
      context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var bottomPadding = (bottomInset ??
            (useSafeArea ? MediaQuery.paddingOf(context).bottom : 0.0)) +
        bottomSpacing.h;

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Shadow.convertRadiusToSigma(4),
        sigmaY: Shadow.convertRadiusToSigma(4),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showHandle)
              Container(
                height: 4.r,
                width: 40.r,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: ShapeDecoration(
                  color: handleColor,
                  shape: const StadiumBorder(),
                ),
              ),
            Flexible(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: CustomScrollView(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          if (showHeader)
                            SkSliverAppBar(
                              title: title ?? '',
                              subtitle: subtitle,
                              titleTextStyle: titleTextStyle,
                              leading: leading ??
                                  (showCloseButton
                                      ? SkCloseButton(
                                          onPressed: onClose ??
                                              () => Navigator.maybePop(context),
                                        )
                                      : const SizedBox.shrink()),
                              actions: actions,
                            ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: padding ?? EdgeInsets.zero,
                              child: child,
                            ),
                          ),
                          if (bottomBar == null)
                            SliverToBoxAdapter(
                              child: SizedBox(height: bottomPadding),
                            ),
                        ],
                      ),
                    ),
                    if (bottomBar != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: bottomPadding),
                        child: bottomBar!,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
