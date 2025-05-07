import 'package:flutter/widgets.dart';

import 'gradient_section_title.dart';
import 'section_subtitle.dart';
import 'section_title.dart';

class SkSectionHeader extends StatelessWidget {
  const SkSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.isGradient = false,
  });

  final String title;
  final String? subtitle;
  final bool isGradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isGradient)
          SkGradientSectionTitle(title)
        else
          SkSectionTitle(title),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          SkSectionSubtitle(subtitle!),
        ]
      ],
    );
  }
}
