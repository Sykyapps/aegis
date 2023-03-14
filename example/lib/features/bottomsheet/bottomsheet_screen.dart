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
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: SkButton(
          label: 'Tap to open Bottom Sheet',
          onPressed: () {
            log('Button pressed');
            showModalBottomSheet(
              context: context,
              // barrierColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              builder: (context) {
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
                    child: CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        const _Header(),
                        SliverToBoxAdapter(
                          child: Column(
                            children: const [
                              ListTile(
                                leading: Icon(Icons.share),
                                title: Text('Share'),
                              ),
                              ListTile(
                                leading: Icon(Icons.link),
                                title: Text('Get link'),
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit name'),
                              ),
                              ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete collection'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
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
  static final double expandedHeight = 108.r;
  static final double leadingWidth = 64.r;

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
      leadingWidth: leadingWidth,
      expandedHeight: expandedHeight,
      backgroundColor: AegisColors.neutral200,
      foregroundColor: AegisColors.neutral500,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraint) {
          double difference(double a, double b) {
            return (a - b).abs();
          }

          var currentHeight = constraint.biggest.height;
          // var scale = difference(currentHeight, height) /
          //     difference(height, expandedHeight);
          return FlexibleSpaceBar(
            centerTitle: false,
            expandedTitleScale: 1,
            title: Text(
              '${difference(currentHeight, height) / difference(height, expandedHeight)}',
              style: AegisFont.headlineMedium.copyWith(
                color: AegisColors.neutral500,
              ),
            ),
          );
        },
      ),
    );
  }
}
