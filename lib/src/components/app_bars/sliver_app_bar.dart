import 'package:aegis/components.dart';
import 'package:aegis/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkSliverAppBar extends StatelessWidget {
  const SkSliverAppBar({
    Key? key,
    this.title,
    this.titleTextStyle,
    this.subtitle,
    this.leading,
    this.onLeadingPressed,
    this.actions,
    this.bottom,
    this.expandedContent,
    this.background,
    this.contentBottomInset = 0,
    this.expandedHeight,
    this.collapsedHeight,
    this.leadingWidth,
    this.pinned = true,
    this.elevation,
    this.scrolledUnderElevation,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.systemOverlayStyle,
  })  : assert(
          title != null || expandedContent != null,
          'SkSliverAppBar requires either a title or an expandedContent.',
        ),
        assert(
          expandedContent == null || expandedHeight != null,
          'expandedHeight is required when expandedContent is provided.',
        ),
        super(key: key);

  /// Title shown in the collapsed toolbar.
  ///
  /// It can be omitted when [expandedContent] is used, so custom headers do
  /// not render a duplicated title in the toolbar.
  final String? title;
  final TextStyle? titleTextStyle;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final Widget? bottom;

  /// Custom content rendered in the expanded area.
  ///
  /// Unlike [FlexibleSpaceBar.background], this content is rendered through
  /// [FlexibleSpaceBar.title], so it stays opaque while the app bar collapses
  /// and is anchored to the bottom of the app bar.
  ///
  /// [expandedHeight] is required when this is provided, so the app bar does
  /// not have to measure content that may depend on a real [BuildContext].
  final Widget? expandedContent;

  /// Optional layer painted behind [expandedContent].
  ///
  /// The widget keeps its intrinsic height and is constrained by the current
  /// app bar extent, so it shrinks/clips instead of fading like
  /// [FlexibleSpaceBar.background] does.
  final Widget? background;

  /// Distance between [expandedContent] and the bottom of the app bar.
  final double contentBottomInset;

  /// Explicit expanded height, **excluding** the status bar padding.
  final double? expandedHeight;

  /// Explicit collapsed height, **excluding** the status bar padding.
  ///
  /// When a [bottom] widget is also provided, the framework adds its height on
  /// top of this value.
  final double? collapsedHeight;

  /// Width reserved for [leading]. Defaults to [toolbarHeight].
  final double? leadingWidth;

  final bool pinned;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? backgroundColor;

  /// Background color used once the app bar is scrolled under. Defaults to
  /// [AegisColors.neutral0].
  final Color? collapsedBackgroundColor;

  /// Status bar style. Defaults to [SystemUiOverlayStyle.dark] with a
  /// transparent status bar.
  final SystemUiOverlayStyle? systemOverlayStyle;

  static const toolbarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    var leadingWidget = leading ??
        SizedBox.square(
          dimension: 32,
          child: SkBackButton(
            onPressed: onLeadingPressed ?? () => Navigator.maybePop(context),
          ),
        );

    var titleWidget = Text(
      title ?? '',
      maxLines: 2,
      style: (titleTextStyle ?? AegisFont.headlineMedium).copyWith(
        overflow: TextOverflow.ellipsis,
      ),
    );
    var subtitleWidget = subtitle == null
        ? const SizedBox.shrink()
        : Text(
            subtitle!,
            maxLines: 2,
            style: AegisFont.bodyMedium.copyWith(
              overflow: TextOverflow.ellipsis,
              color: AegisColors.textLowEmphasis,
            ),
          );

    var flexibleSpaceWidgets = Container(
      width: 1.sw,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ).copyWith(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          titleWidget,
          subtitleWidget,
        ],
      ),
    );

    var bottomWidgetHeight =
        MeasurementUtil.measureWidget(bottom ?? const SizedBox.shrink()).height;

    var hasCustomContent = expandedContent != null;

    var flexibleSpaceHeight = hasCustomContent
        ? 0.0
        : MeasurementUtil.measureWidget(flexibleSpaceWidgets).height;

    var effectiveExpandedHeight = expandedHeight ??
        (toolbarHeight + flexibleSpaceHeight + bottomWidgetHeight);

    // The custom content is already bottom-anchored inside its own extent, so
    // compare the collapsed distance directly instead of the default content
    // height.
    var scrolledUnderThreshold = hasCustomContent
        ? effectiveExpandedHeight - (collapsedHeight ?? toolbarHeight)
        : flexibleSpaceHeight;

    var flexibleSpace = hasCustomContent
        ? FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            titlePadding: EdgeInsets.zero,
            expandedTitleScale: 1,
            // Rendered through `title` (not `background`) to keep the content
            // fully opaque while collapsing. `background` is kept as the first
            // non-positioned child so it follows the header extent without
            // fading.
            title: Stack(
              children: [
                if (background != null) background!,
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: contentBottomInset,
                  child: expandedContent!,
                ),
              ],
            ),
          )
        : FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: flexibleSpaceWidgets,
                ),
              ],
            ),
          );

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        var isScrolledUnder = constraints.scrollOffset > scrolledUnderThreshold;
        return SliverAppBar(
          pinned: pinned,
          toolbarHeight: toolbarHeight + bottomWidgetHeight,
          expandedHeight: effectiveExpandedHeight,
          collapsedHeight: collapsedHeight,
          elevation: elevation,
          scrolledUnderElevation: scrolledUnderElevation,
          backgroundColor: isScrolledUnder
              ? (collapsedBackgroundColor ??
                  backgroundColor ??
                  AegisColors.neutral0)
              : (backgroundColor ?? AegisColors.transparent),
          systemOverlayStyle: systemOverlayStyle ??
              SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: AegisColors.transparent,
              ),
          title: isScrolledUnder && title != null ? Text(title!) : null,
          titleTextStyle: AegisFont.headlineSmall.copyWith(
            color: AegisColors.textHighEmphasis,
          ),
          centerTitle: true,
          titleSpacing: 0,
          leadingWidth: leadingWidth ?? toolbarHeight,
          leading: FittedBox(
            fit: BoxFit.none,
            child: leadingWidget,
          ),
          flexibleSpace: flexibleSpace,
          actions: isScrolledUnder ? [] : actions,
        );
      },
    );
  }
}
