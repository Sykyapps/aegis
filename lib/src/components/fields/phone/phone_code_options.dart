import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../aegis.dart';

class PhoneCodeOptions extends HookWidget {
  const PhoneCodeOptions({super.key, required this.phoneCodes});

  final List<Map<String, dynamic>> phoneCodes;

  static const radius = Radius.circular(16);

  static Future<Map<String, dynamic>?> show(
    BuildContext context,
    List<Map<String, dynamic>> phoneCodes,
  ) {
    var selected = showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return PhoneCodeOptions(phoneCodes: phoneCodes);
      },
    );

    return selected;
  }

  @override
  Widget build(BuildContext context) {
    var codes = useState<List<Map<String, dynamic>>>(phoneCodes);
    var controller = useTextEditingController();

    void onChanged(String value) {
      value = value.toLowerCase();
      codes.value = phoneCodes
          .where((c) =>
              (c['name'] as String).toLowerCase().contains(value) ||
              (c['phoneCode'] as String).toLowerCase().startsWith(value))
          .toList();
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Shadow.convertRadiusToSigma(4),
        sigmaY: Shadow.convertRadiusToSigma(4),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
          color: AegisColors.neutral0,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          maxChildSize: .93,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              slivers: [
                _Header(controller: controller, onChanged: onChanged),
                SliverList(
                  delegate: SliverChildListDelegate(
                    codes.value
                        .map((c) => ListTile(
                              leading:
                                  SvgPicture.network(c['flagUrl'], width: 25.r),
                              title: Text('${c['name']} (+${c['phoneCode']})'),
                              onTap: () => Navigator.of(context).pop(c),
                            ))
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.controller, required this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final Function(String) onChanged;

  static final double height = 64.r;
  static final double expandedHeight = 156.r;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      expandedHeight: expandedHeight,
      backgroundColor: AegisColors.neutral0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraint) {
          var top = constraint.biggest.height;
          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const _CloseButton(),
                    AnimatedOpacity(
                      opacity: top <= 166 ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const _Title(),
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: top > 166 ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20).r,
                    child: const _Title(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20).r,
          child: SkSearchField(
            controller: controller,
            hintText: 'Cari nama negara atau kode negara',
            onChanged: onChanged,
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
    return IconButton(
      iconSize: 24.sp,
      padding: EdgeInsets.zero,
      icon: const Icon(
        AegisIcons.close,
        color: AegisColors.iconHighEmphasis,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Kode Negara',
      style: AegisFont.headlineMedium.copyWith(
        color: AegisColors.neutral500,
      ),
    );
  }
}
