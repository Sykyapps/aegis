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
                    return const _SkBottomSheet(
                      useDraggableScrollableSheet: false,
                      child: SizedBox(),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            SkButton(
              label: 'Tap to open Scrollable Bottom Sheet',
              onPressed: () async {
                log('Button pressed');

                await SkBottomSheet(
                  title: 'Title',
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        color: AegisColors.purple100,
                      ),
                      const TextField(),
                      Container(
                        height: 1000,
                        color: AegisColors.purple200,
                      ),
                    ],
                  ),
                ).show(context);
              },
            ),
            const SizedBox(height: 8),
            SkButton(
              label: 'Tap to open Searchable Bottom Sheet',
              onPressed: () async {
                log('Button pressed');

                await SkSearchableOptionsBottomSheet<String>(
                  title: 'Undang Teman',
                  searchHint: 'Cari nama kontak ataupun nomor ponsel',
                  emptyTitle: 'Kontak Tidak Ditemukan',
                  emptyDescription:
                      'Coba periksa atau ganti kata kunci yang ingin kamu cari.',
                  options: const [
                    'Calvin Andhika',
                    'Bukan Siapa Siapa',
                    'dddsss',
                    'jjj',
                    'hhhh',
                    'asd',
                    'bsd',
                    'dddsss',
                    'jjj',
                    'hhhh',
                    'asd',
                    'bsd',
                    'dddsss',
                    'jjj',
                    'hhhh',
                  ],
                  groupByAlphabet: true,
                  getLabel: (p0) => p0,
                  getImage: (p0) => '',
                  getSubtitle: (p0) => p0,
                  trailingButton: const _Button(isSelected: true),
                  actionButton: const _ActionButton(),
                  disableUnfocusBehavior: true,
                ).show(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          color: AegisColors.neutral100,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Text(
            '1 dari 10 diundang',
            style: AegisFont.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: SkButton(
            label: 'Undang',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? SkIconButton(
            width: 100,
            title: 'Diundang',
            iconSize: 17,
            textStyle: AegisFont.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: AegisColors.neutral300,
            ),
            foregroundColor: AegisColors.neutral300,
            backgroundColor: AegisColors.neutral0,
            border: const BorderSide(color: AegisColors.neutral200),
            icon: AegisIcons.check,
            onPressed: () {},
          )
        : SkIconButton(
            width: 100,
            title: 'Undang',
            iconSize: 17,
            textStyle: AegisFont.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: AegisColors.purple300,
            ),
            border: const BorderSide(color: AegisColors.purple100),
            foregroundColor: AegisColors.purple300,
            backgroundColor: AegisColors.purple100,
            icon: AegisIcons.add,
            onPressed: () {},
          );
  }
}

class _SkBottomSheet extends StatelessWidget {
  const _SkBottomSheet({
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
