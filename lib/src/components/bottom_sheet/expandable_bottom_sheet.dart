import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../aegis.dart';

class SkExpandableBottomSheet extends HookWidget {
  const SkExpandableBottomSheet({
    super.key,
    this.title = '',
    this.isExpandable = true,
    required this.child,
  });

  final String title;
  final bool isExpandable;
  final Widget child;

  static const radius = Radius.circular(16);
  static const minSheetScale = .25;
  static const maxSheetScale = .93;

  static final minSheetHeight = 1.sh * minSheetScale;
  static final maxSheetHeight = 1.sh * maxSheetScale;
  static final minExpandedHeight = 103.r;
  static final maxExpandedHeight = 146.r;

  static Future<T?> show<T>(
    BuildContext context, {
    String title = '',
    bool isExpandable = true,
    Widget child = const SizedBox(),
  }) {
    var result = showModalBottomSheet<T?>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SkExpandableBottomSheet(
        title: title,
        isExpandable: isExpandable,
        child: child,
      ),
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var expandedHeight = minExpandedHeight;

    var titleRef = MeasurementUtil.measureWidget(
      const _ExpandedTitle(title: 'Title'),
    );
    var titleSize = MeasurementUtil.measureWidget(_ExpandedTitle(title: title));
    if (titleSize.height > titleRef.height) expandedHeight = maxExpandedHeight;

    var childHeight = MeasurementUtil.measureWidget(child).height;
    var totalHeight = expandedHeight + childHeight + context.bottomPadding;

    var sheetSize = totalHeight / 1.sh;

    var isExceedMaxHeight = totalHeight > maxSheetHeight;
    if (isExceedMaxHeight) sheetSize = maxSheetScale;

    var isBreakMinHeight = totalHeight < minSheetHeight;
    if (isBreakMinHeight) sheetSize = minSheetScale;

    var maxSize = maxSheetScale;
    var minSize = minSheetScale;
    if (!isExpandable && !isExceedMaxHeight) {
      minSize = sheetSize;
      maxSize = sheetSize;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Shadow.convertRadiusToSigma(4),
        sigmaY: Shadow.convertRadiusToSigma(4),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -12.r,
            child: Container(
              height: 4.r,
              width: 40.r,
              decoration: const ShapeDecoration(
                color: AegisColors.backgroundWhite,
                shape: StadiumBorder(),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.only(bottom: context.bottomPadding),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                ),
                color: AegisColors.neutral0,
              ),
              child: DraggableScrollableSheet(
                expand: false,
                snap: true,
                initialChildSize: sheetSize,
                minChildSize: minSize,
                maxChildSize: maxSize,
                builder: (context, scrollController) {
                  return CustomScrollView(
                    controller: scrollController,
                    physics: !isExpandable
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    shrinkWrap: true,
                    slivers: [
                      _Header(title: title, expandedHeight: expandedHeight),
                      SliverFillRemaining(child: child),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.title, required this.expandedHeight})
      : super(key: key);

  final String title;
  final double expandedHeight;

  static final collapsedHeight = 56.r;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 4,
      shadowColor: AegisColors.shadowEvelation1,
      automaticallyImplyLeading: false,
      toolbarHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      backgroundColor: AegisColors.neutral0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraint) {
          var top = constraint.biggest.height;
          var isCollapsed = top < expandedHeight;

          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                SkSemantics(
                  label: 'Collapsed Title Group',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const _CloseButton(),
                      if (title.isNotEmpty)
                        Expanded(
                          child: AnimatedOpacity(
                            opacity: isCollapsed ? 1 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: _CollapsedTitle(title: title),
                          ),
                        ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                if (title.isNotEmpty)
                  Visibility(
                    visible: !isCollapsed,
                    maintainState: true,
                    maintainAnimation: true,
                    child: AnimatedOpacity(
                      opacity: !isCollapsed ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: _ExpandedTitle(title: title),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20.sp,
      padding: EdgeInsets.zero,
      icon: const Icon(
        AegisIcons.close,
        color: AegisColors.iconHighEmphasis,
        semanticLabel: 'Close Button',
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _CollapsedTitle extends StatelessWidget {
  const _CollapsedTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AegisFont.headlineSmall.copyWith(
        color: AegisColors.neutral500,
      ),
    );
  }
}

class _ExpandedTitle extends StatelessWidget {
  const _ExpandedTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AegisFont.headlineMedium.copyWith(
          color: AegisColors.neutral500,
        ),
      ),
    );
  }
}
