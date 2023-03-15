import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../foundation.dart';

class PhonePrefix extends StatelessWidget {
  const PhonePrefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AegisColors.neutral100,
        borderRadius: BorderRadius.circular(2).r,
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4).r,
      margin: const EdgeInsets.only(right: 8).r,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.network(
            'https://storage.googleapis.com/sayakaya-static/country_flags/indonesia.svg',
            width: 25.r,
          ),
          SizedBox(width: 4.r),
          Text(
            '+62',
            style: AegisFont.bodyLarge.copyWith(
              color: AegisColors.neutral400,
              height: 24 / 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 4.r),
          Icon(Icons.keyboard_arrow_down, size: 16.r),
        ],
      ),
    );
  }
}
