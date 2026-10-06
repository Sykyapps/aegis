import 'package:flutter/foundation.dart';
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
    this.leading,
    this.onLeadingPressed,
    this.actions,
    this.bottomNavigationBar,
    this.additionalHeader,
    this.scrollController,
    this.onLoadMore,
    this.onRefresh,
  });

  final String title;
  final bool? isTwoLineTitle;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final List<Widget> slivers;
  final Widget? bottomNavigationBar;
  final Widget? additionalHeader;
  final ScrollController? scrollController;
  final VoidCallback? onLoadMore;
  final AsyncCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    var slivers = [
      SkSliverAppBar(
        title: title,
        subtitle: subtitle,
        leading: leading,
        onLeadingPressed: onLeadingPressed,
        actions: actions,
      ),
      PinnedHeaderSliver(child: additionalHeader),
      ...this.slivers,
    ];
    return SkScaffold(
      body: _InfiniteScrollView(
        onLoadMore: onLoadMore,
        builder: (_) {
          if (onRefresh == null) {
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              slivers: slivers,
            );
          }
          return RefreshIndicator.adaptive(
            onRefresh: onRefresh!,
            displacement: 16.h,
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              slivers: slivers,
            ),
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _InfiniteScrollView extends StatelessWidget {
  const _InfiniteScrollView({
    required this.builder,
    this.onLoadMore,
  });

  final VoidCallback? onLoadMore;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    if (onLoadMore == null) return Builder(builder: builder);

    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.depth != 0) return true;
        var metrics = notification.metrics;
        if (metrics.pixels >= metrics.maxScrollExtent - 80) {
          onLoadMore?.call();
        }
        return true;
      },
      child: Builder(builder: builder),
    );
  }
}
