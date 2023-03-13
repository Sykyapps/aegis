import 'package:aegis/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  final int width;
  const SkIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.width = 125,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      margin: const EdgeInsets.fromLTRB(12, 12, 0, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: AegisColors.neutral500,
        ),
        label: Text(
          title,
          style: AegisFont.bodyMedium.copyWith(
            color: AegisColors.neutral500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AegisColors.neutral0,
          elevation: 0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
