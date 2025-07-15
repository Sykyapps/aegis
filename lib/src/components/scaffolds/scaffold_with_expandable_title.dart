import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

class SkScaffoldWithExpandableTitle extends StatelessWidget {
  const SkScaffoldWithExpandableTitle({
    super.key,
    required this.slivers,
    required this.title,
    this.isTwoLineTitle,
    this.subtitle,
    this.leadingIcon,
    this.bottomNavigationBar,
    this.additionalHeader,
    this.scrollController,
    this.onLoadMore,
  });

  final String title;
  final bool? isTwoLineTitle;
  final String? subtitle;
  final IconData? leadingIcon;
  final List<Widget> slivers;
  final Widget? bottomNavigationBar;
  final Widget? additionalHeader;
  final ScrollController? scrollController;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (_, __) {
          double topSpace = 8.r;
          double toolbarHeight = 48.r;
          double additionalHeight = 0;

          if (additionalHeader != null) {
            Size additionalSize =
                MeasurementUtil.measureWidget(additionalHeader!);
            additionalHeight = additionalSize.height;
          }

          double collapsedHeight = toolbarHeight + additionalHeight;

          var expandedTitleHeight = MeasurementUtil.measureWidget(
            SizedBox(
              width: 1.sw - 40.r,
              child: Text(
                title,
                style: AegisFont.headlineMedium,
                maxLines: 2,
                softWrap: true,
              ),
            ),
          ).height;

          if (isTwoLineTitle ?? false) {
            var oneLineHeight = MeasurementUtil.measureWidget(
              SizedBox(
                width: 1.sw - 40.r,
                child: Text(
                  'Test',
                  style: AegisFont.headlineMedium,
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
            ).height;
            expandedTitleHeight = oneLineHeight * 2;
          }

          double totalExpandedHeight =
              collapsedHeight + expandedTitleHeight + topSpace;

          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              collapsedHeight: collapsedHeight,
              toolbarHeight: toolbarHeight,
              expandedHeight: totalExpandedHeight,
              backgroundColor: AegisColors.backgroundWhite,
              leading: IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                iconSize: 20.sp,
                color: AegisColors.iconHighEmphasis,
                icon: Icon(leadingIcon ?? AegisIcons.chevron_left),
                onPressed: () => Navigator.of(context).pop(),
              ),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  var settings = context.dependOnInheritedWidgetOfExactType<
                      FlexibleSpaceBarSettings>()!;

                  var deltaExtent = settings.maxExtent - settings.minExtent;

                  double value = (1.0 -
                          (settings.currentExtent - settings.minExtent) /
                              deltaExtent)
                      .clamp(0.0, 1.0);

                  double begin = math.max(0, 1 - toolbarHeight / deltaExtent);
                  double end = 1;
                  double interval = Interval(begin, end).transform(value);
                  double opacity = 1 - interval;

                  return SafeArea(
                    child: ColoredBox(
                      color: AegisColors.backgroundWhite,
                      child: Stack(
                        children: [
                          _AppBarTitle.collapsed(
                            toolbarHeight: toolbarHeight,
                            title: title,
                            opacity: opacity,
                          ),
                          _AppBarTitle.expanded(
                            toolbarHeight: toolbarHeight,
                            title: title,
                            opacity: opacity,
                            bottom: additionalHeight,
                          ),
                          if (additionalHeader != null)
                            Positioned(
                              bottom: 0,
                              child: additionalHeader!,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (subtitle != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 28).w,
                  child: Text(
                    subtitle!,
                    style: AegisFont.bodyMedium.copyWith(
                      color: AegisColors.textHighEmphasis,
                    ),
                  ),
                ),
              ),
          ];
        },
        body: _InfiniteScrollView(
          onLoadMore: onLoadMore,
          child: CustomScrollView(
            slivers: slivers,
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final double toolbarHeight;
  final double opacity;
  final String title;
  final bool isExpand;
  final double? bottom;

  static _AppBarTitle expanded({
    required double toolbarHeight,
    required String title,
    required double opacity,
    double? bottom,
  }) {
    return _AppBarTitle._(
      toolbarHeight: toolbarHeight,
      opacity: opacity,
      title: title,
      isExpand: true,
      bottom: bottom,
    );
  }

  static _AppBarTitle collapsed({
    required double toolbarHeight,
    required String title,
    required double opacity,
  }) {
    return _AppBarTitle._(
      toolbarHeight: toolbarHeight,
      opacity: opacity,
      title: title,
      isExpand: false,
    );
  }

  const _AppBarTitle._({
    required this.toolbarHeight,
    required this.title,
    required this.isExpand,
    required this.opacity,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isExpand ? null : 0,
      bottom: bottom ?? (isExpand ? 0 : null),
      left: isExpand ? 20.r : 60.r,
      height: isExpand ? null : toolbarHeight,
      width: 1.sw - (isExpand ? 40.r : 120.r),
      child: Opacity(
        opacity: isExpand ? opacity : 1 - opacity,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style:
                isExpand ? AegisFont.headlineMedium : AegisFont.headlineSmall,
            maxLines: isExpand ? 2 : 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _InfiniteScrollView extends StatelessWidget {
  const _InfiniteScrollView({
    required this.child,
    this.onLoadMore,
  });

  final VoidCallback? onLoadMore;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (onLoadMore == null) return child;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.depth != 0) return true;

        var metrics = notification.metrics;
        if (metrics.pixels == metrics.maxScrollExtent) {
          onLoadMore?.call();
        }

        return true;
      },
      child: child,
    );
  }
}
