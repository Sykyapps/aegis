import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkSliverAppBar extends StatelessWidget {
  const SkSliverAppBar({
    Key? key,
    required this.title,
    required this.expandedHeight,
    this.leading,
    this.action,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? action;
  final double expandedHeight;

  static const collapsedHeight = 64.0;

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    leading ?? const SizedBox(),
                    if (title.isNotEmpty)
                      Expanded(
                        child: AnimatedOpacity(
                          opacity: isCollapsed ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: _CollapsedTitle(title: title),
                        ),
                      ),
                    action ?? const SizedBox(),
                    const SizedBox(width: 8),
                  ],
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
                const SizedBox(height: 4),
              ],
            ),
          );
        },
      ),
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
