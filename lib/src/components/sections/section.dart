import 'package:flutter/widgets.dart';

import 'section_header.dart';

class SkSection extends StatelessWidget {
  const SkSection({
    super.key,
    required this.title,
    this.subtitle,
    this.isHighlight = false,
    required this.child,
    this.titleStyle,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final bool isHighlight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SkSectionHeader(
            title: title,
            titleStyle: titleStyle,
            subtitle: subtitle,
            isGradient: isHighlight,
          ),
        ),
        const SizedBox(height: 12),
        child,
        const SizedBox(height: 16),
      ],
    );
  }
}
