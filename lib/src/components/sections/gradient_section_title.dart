import 'package:flutter/material.dart';

import 'section_title.dart';

class SkGradientSectionTitle extends StatelessWidget {
  const SkGradientSectionTitle(this.title, {Key? key, this.titleStyle})
      : super(key: key);

  final String title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(151, 71, 255, 1),
          Color.fromRGBO(77, 104, 220, 1),
        ],
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: SkSectionTitle(title, titleStyle: titleStyle),
    );
  }
}
