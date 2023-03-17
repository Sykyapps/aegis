import 'phone_code_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components.dart';
import '../../../../foundation.dart';

const indonesiaCode = {
  "name": "Indonesia",
  "phoneCode": "62",
  "flagUrl":
      "https://storage.googleapis.com/sayakaya-static/country_flags/indonesia.svg"
};

class PhonePrefix extends HookWidget {
  const PhonePrefix({Key? key, this.phoneCodes, this.onSelected})
      : super(key: key);

  final List<Map<String, dynamic>>? phoneCodes;
  final Function(String)? onSelected;

  Map<String, dynamic> get defaultCode =>
      phoneCodes?.firstWhere((pc) => pc['phoneCode'] == '62',
          orElse: () => indonesiaCode) ??
      indonesiaCode;

  @override
  Widget build(BuildContext context) {
    var selected = useState<Map<String, dynamic>>(defaultCode);

    return InkWell(
      onTap: phoneCodes == null
          ? null
          : () async {
              var code = await PhoneCodeOptions.show(context, phoneCodes!);
              if (code == null) return;
              selected.value = code;
              onSelected?.call(code['phoneCode']);
            },
      child: Container(
        decoration: BoxDecoration(
          color: AegisColors.neutral100,
          borderRadius: BorderRadius.circular(2).r,
        ),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4).r,
        margin: const EdgeInsets.only(right: 8).r,
        child: phoneCodes == null
            ? const _Loading()
            : _PhoneCode(phoneCode: selected.value),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.r,
      width: 77.r,
      child: const SkLoadingAnimation(size: 18, color: AegisColors.purple300),
    );
  }
}

class _PhoneCode extends StatelessWidget {
  const _PhoneCode({Key? key, this.phoneCode}) : super(key: key);

  final Map<String, dynamic>? phoneCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.network(
          phoneCode?['flagUrl'],
          width: 25.r,
        ),
        SizedBox(width: 4.r),
        Text(
          '+${phoneCode?["phoneCode"]}',
          style: AegisFont.bodyLarge.copyWith(
            color: AegisColors.neutral400,
            height: 24 / 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 4.r),
        Icon(
          Icons.keyboard_arrow_down,
          size: 16.r,
          color: AegisColors.neutral400,
        ),
      ],
    );
  }
}
