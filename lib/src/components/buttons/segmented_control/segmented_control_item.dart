import 'package:aegis/foundation.dart';
import 'package:flutter/material.dart';

class SkSegmentedControlItem extends StatelessWidget {
  final String? label;
  final double? height;

  const SkSegmentedControlItem({
    Key? key,
    this.label,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.maxFinite,
      alignment: Alignment.center,
      child: Text(
        '$label',
        textAlign: TextAlign.center,
        style: AegisFont.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
