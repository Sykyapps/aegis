import 'package:flutter/material.dart';

import '../../../foundation.dart';

class SkInfoChip extends StatelessWidget {
  const SkInfoChip({
    super.key,
    required this.label,
    required this.labelColor,
    required this.backgroundColor,
  });

  final String label;
  final Color labelColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: backgroundColor,
      ),
      child: Text(
        label,
        style: AegisFont.small.copyWith(
          fontWeight: FontWeight.w700,
          color: labelColor,
        ),
      ),
    );
  }
}
