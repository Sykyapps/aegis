import 'package:aegis/foundation.dart';
import 'package:flutter/widgets.dart';

class SkSectionSubtitle extends StatelessWidget {
  const SkSectionSubtitle(this.subtitle, {super.key});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: AegisFont.bodyMedium.copyWith(
        color: AegisColors.neutral400,
      ),
    );
  }
}
