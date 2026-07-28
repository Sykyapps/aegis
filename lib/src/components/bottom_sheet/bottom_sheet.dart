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
    this.expandedHeight = 100,
    this.backgroundImage,
    this.barrierColor,
    this.showHandle = true,
    this.hasBottomNav = false,
  }) : super(key: key);

  final String? title;
  final double expandedHeight;
  final ImageProvider<Object>? backgroundImage;
  final Widget? child;
  final Color? barrierColor;
  final bool showHandle;
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
    var mq = MediaQuery.of(context);

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
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
          decoration: BoxDecoration(
            color: AegisColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.r),
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              slivers: [
                SkSliverAppBar(
                  title: title ?? '',
                  expandedHeight: expandedHeight,
                  leading: const _CloseButton(),
                ),
                SliverToBoxAdapter(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AegisColors.backgroundWhite,
          shape: BoxShape.circle,
        ),
        child: Icon(
          AegisIcons.close,
          size: 20.sp,
          color: AegisColors.textHighEmphasis,
        ),
      ),
    );
  }
}
