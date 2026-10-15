import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

class SkBottomSheet extends HookWidget {
  const SkBottomSheet({
    Key? key,
    required this.child,
    this.title,
    this.subtitle,
    this.titleTextStyle,
    this.expandedHeight = 100,
    this.backgroundImage,
    this.barrierColor,
    this.showHandle = true,
    this.showCloseButton = true,
    this.hasBottomNav = false,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final TextStyle? titleTextStyle;
  final double expandedHeight;
  final ImageProvider<Object>? backgroundImage;
  final Widget? child;
  final Color? barrierColor;
  final bool showHandle;
  final bool showCloseButton;
  final bool hasBottomNav;

  Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool?>(
      context: context,
      constraints: BoxConstraints(
        maxHeight: hasBottomNav
            ? 1.sh -
                ScreenUtil().statusBarHeight -
                ScreenUtil().bottomBarHeight -
                kBottomNavigationBarHeight
            : 1.sh - ScreenUtil().statusBarHeight,
      ),
      backgroundColor: AegisColors.transparent,
      barrierColor: barrierColor ?? const Color.fromRGBO(4, 8, 22, 0.6),
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var scrollController = useScrollController();
    var isPinned = useState(false);

    useEffect(() {
      scrollController.addListener(() {
        isPinned.value =
            scrollController.hasClients && scrollController.offset > 56.r;
      });
      return;
    }, [scrollController]);

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Shadow.convertRadiusToSigma(2),
        sigmaY: Shadow.convertRadiusToSigma(2),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showHandle)
              Container(
                height: 4.r,
                width: 40.r,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: const ShapeDecoration(
                  color: AegisColors.backgroundWhite,
                  shape: StadiumBorder(),
                ),
              ),
            Flexible(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AegisColors.backgroundWhite,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: SkKeyboardInsetPadding(
                  child: CustomScrollView(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SkSliverAppBar(
                        title: title ?? '',
                        subtitle: subtitle,
                        titleTextStyle: titleTextStyle,
                        leading: showCloseButton
                            ? SkCloseButton(
                                onPressed: () => Navigator.maybePop(context),
                              )
                            : const SizedBox.shrink(),
                      ),
                      SliverToBoxAdapter(child: child),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
