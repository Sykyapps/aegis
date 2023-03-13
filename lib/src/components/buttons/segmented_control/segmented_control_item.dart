import 'package:aegis/foundation.dart';
import 'package:flutter/material.dart';

class SkSegmentedControlItem extends StatelessWidget {
  final String? label;

  const SkSegmentedControlItem({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
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
