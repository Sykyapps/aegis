import 'package:aegis/components.dart';
import 'package:aegis/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkSliverAppBar extends StatelessWidget {
  const SkSliverAppBar({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onLeadingPressed,
    this.actions,
    this.bottom,
  }) : super(key: key);

  final String title;
  final String? subtitle;

  /// ```
  /// FittedBox(
  ///   fit: BoxFit.none,
  ///   child: SizedBox.square(
  ///     dimension: 32,
  ///     child: SkBackButton(
  ///       onPressed: () => Navigator.maybePop(context),
  ///     ),
  ///   ),
  /// ),
  ///```
  final Widget? leading;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final Widget? bottom;

  static const toolbarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    var titleWidget = Text(
      title,
      maxLines: 1,
      style: AegisFont.headlineMedium.copyWith(
        overflow: TextOverflow.ellipsis,
      ),
    );
    var subtitleWidget = subtitle == null
        ? const SizedBox.shrink()
        : Text(
            subtitle!,
            maxLines: 2,
            style: AegisFont.bodySmall.copyWith(
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

    var flexibleSpaceHeight =
        MeasurementUtil.measureWidget(flexibleSpaceWidgets).height;

    var bottomWidgetHeight =
        MeasurementUtil.measureWidget(bottom ?? const SizedBox.shrink()).height;

    var expandedHeight = toolbarHeight + flexibleSpaceHeight;

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        var isScrolledUnder = constraints.scrollOffset > flexibleSpaceHeight;
        return SliverAppBar(
          pinned: true,
          toolbarHeight: toolbarHeight + bottomWidgetHeight,
          expandedHeight: expandedHeight,
          backgroundColor:
              isScrolledUnder ? AegisColors.neutral0 : AegisColors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: AegisColors.transparent,
          ),
          title: isScrolledUnder ? Text(title) : null,
          titleTextStyle: AegisFont.headlineSmall.copyWith(
            color: AegisColors.textHighEmphasis,
          ),
          titleSpacing: 0,
          leadingWidth: toolbarHeight,
          leading: leading ??
              FittedBox(
                fit: BoxFit.none,
                child: SizedBox.square(
                  dimension: 32,
                  child: SkBackButton(
                    onPressed:
                        onLeadingPressed ?? () => Navigator.maybePop(context),
                  ),
                ),
              ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  width: 1.sw,
                  child: flexibleSpaceWidgets,
                ),
              ],
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
