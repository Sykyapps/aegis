import 'dart:developer';
import 'dart:ui';
import 'dart:core';

import 'package:aegis/components.dart';
import 'package:aegis/foundation.dart';
import 'package:aegis/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheet')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkButton(
              label: 'Basic Bottom Sheet',
              onPressed: () {
                SkExpandableBottomSheet.show(
                  context,
                  title: 'Basic Bottom Sheet Panjang Banget',
                  isExpandable: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      4,
                      (index) => SkButton(label: '$index'),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            SkButton(
              label: 'Tap to open Bottom Sheet',
              onPressed: () {
                log('Button pressed');
                var mq = MediaQuery.of(context);
                showModalBottomSheet(
                  context: context,
                  // barrierColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    maxHeight: mq.size.height - mq.viewPadding.top,
                  ),

                  builder: (context) {
                    return const SkBottomSheet();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SkBottomSheet extends StatelessWidget {
  const SkBottomSheet({
    Key? key,
    this.child,
    this.useDraggableScrollableSheet = false,
  }) : super(key: key);

  final bool useDraggableScrollableSheet;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Shadow.convertRadiusToSigma(4),
        sigmaY: Shadow.convertRadiusToSigma(4),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16).r,
          color: AegisColors.neutral0,
        ),
        child: useDraggableScrollableSheet
            ? DraggableScrollableSheet(
                expand: false,
                builder: (context, scrollController) {
                  return CustomScrollView(
                    controller: scrollController,
                    shrinkWrap: true,
                    slivers: [
                      const _Header(),
                      SliverToBoxAdapter(
                        child: child ?? Padding(padding: EdgeInsets.all(20.r)),
                      )
                    ],
                  );
                },
              )
            : CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  const _Header(),
                  SliverToBoxAdapter(
                    child: child ?? Padding(padding: EdgeInsets.all(20.r)),
                  )
                ],
              ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  static final double height = 56.r;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(AegisIcons.close),
        onPressed: () {},
      ),
      toolbarHeight: height,
      backgroundColor: AegisColors.neutral200,
      foregroundColor: AegisColors.neutral500,
    );
  }
}
