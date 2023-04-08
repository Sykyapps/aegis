import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

class SkBottomSheet extends HookWidget {
  const SkBottomSheet({
    Key? key,
    this.useDraggableScrollableSheet = false,
    required this.child,
    this.title,
    this.backgroundImage,
  }) : super(key: key);

  final bool useDraggableScrollableSheet;
  final String? title;
  final ImageProvider<Object>? backgroundImage;
  final Widget? child;

  static void show(
    BuildContext context, {
    String? title,
    Widget? child,
  }) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .93,
      ),
      backgroundColor: AegisColors.transparent,
      barrierColor: const Color.fromRGBO(4, 8, 22, 0.6),
      isScrollControlled: true,
      builder: (context) {
        var mq = MediaQuery.of(context);

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: Shadow.convertRadiusToSigma(2),
            sigmaY: Shadow.convertRadiusToSigma(2),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
            decoration: BoxDecoration(
              color: AegisColors.backgroundWhite,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.r),
              ),
            ),
            child: SkBottomSheet(
              title: title,
              // backgroundImage: backgroundImage,
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textController = useTextEditingController();
    var scrollController = useScrollController();
    var isPinned = useState(false);

    useEffect(() {
      scrollController.addListener(() {
        isPinned.value =
            scrollController.hasClients && scrollController.offset > 56.r;
      });
      return;
    }, [scrollController]);

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      slivers: [
        _Header(
          title: title,
          controller: textController,
          backgroundColor: isPinned.value
              ? AegisColors.backgroundWhite
              : AegisColors.transparent,
          onChanged: (p0) {},
        ),
        SliverToBoxAdapter(
          child: child,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.title,
    this.backgroundColor,
  }) : super(key: key);

  final String? title;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Color? backgroundColor;

  static final double height = 56.r;
  static final double expandedHeight = 80.r;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: backgroundColor == AegisColors.transparent ? 64.r : height,
      expandedHeight: title == null ? null : expandedHeight,
      backgroundColor: backgroundColor ?? AegisColors.neutral0,
      centerTitle: false,
      titleSpacing: backgroundColor == AegisColors.transparent ? 0 : null,
      title: backgroundColor == AegisColors.transparent
          ? ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8.r),
                shape: const CircleBorder(),
                backgroundColor: AegisColors.backgroundWhite,
                foregroundColor: AegisColors.textHighEmphasis,
              ),
              child: Icon(
                AegisIcons.close,
                size: 16.r,
              ),
            )
          : const _CloseButton(),
      flexibleSpace: title == null
          ? null
          : LayoutBuilder(
              builder: (context, constraint) {
                var top = constraint.biggest.height;
                return FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  titlePadding: EdgeInsets.zero,
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.r,
                            vertical: 16.r,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const _CloseButton(),
                              SizedBox(width: 16.r),
                              Visibility(
                                visible: top <= 75,
                                maintainAnimation: true,
                                maintainState: true,
                                child: AnimatedOpacity(
                                  opacity: top <= 75 ? 1 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    title!,
                                    style: AegisFont.headlineSmall.copyWith(
                                      color: AegisColors.neutral500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: top >= 75,
                        maintainAnimation: true,
                        maintainState: true,
                        child: AnimatedOpacity(
                          opacity: top >= 75 ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20).r,
                            child: Text(
                              title!,
                              style: AegisFont.headlineMedium.copyWith(
                                color: AegisColors.neutral500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(height),
      //   child: Container(
      //     alignment: Alignment.center,
      //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20).r,
      //     child: SkSearchField(
      //       controller: controller,
      //       hintText: 'Cari nama negara atau kode negara',
      //       onChanged: onChanged,
      //     ),
      //   ),
      // ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      iconSize: 24.sp,
      color: AegisColors.iconHighEmphasis,
      icon: const Icon(AegisIcons.close),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
