import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../components.dart';
import '../../../foundation.dart';
import '../../utils/currency_util.dart';

class SkNominalField extends HookWidget {
  const SkNominalField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    required this.onChanged,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    var ctrl = controller ?? useTextEditingController();
    var textUpdate = useValueListenable(ctrl);
    var fn = useFocusNode();

    useEffect(() {
      ctrl.value = textUpdate;
      return;
    }, [textUpdate]);

    return SkCard(
      backgroundColor: AegisColors.neutral100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelText != null) ...[
              Text(
                labelText!,
                style: AegisFont.bodySmall.copyWith(
                  color: AegisColors.neutral300,
                ),
              ),
              SizedBox(height: 4.r),
            ],
            TextFormField(
              focusNode: fn,
              controller: ctrl,
              onChanged: (value) {
                onChanged(CurrencyUtil.parse(value).toString());
              },
              style: AegisFont.headlineSmall.copyWith(
                color: AegisColors.neutral500,
              ),
              cursorWidth: 1.w,
              cursorColor: AegisColors.blue300,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                fillColor: AegisColors.neutral100,
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: AegisFont.headlineSmall
                    .copyWith(color: AegisColors.neutral300),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  if (newValue.selection.baseOffset == 0) {
                    return newValue;
                  }

                  double value = double.parse(newValue.text);
                  final fmt = NumberFormat.simpleCurrency(
                    locale: 'id_ID',
                    decimalDigits: 0,
                  );

                  final formattedValue = fmt.format(value);
                  return newValue.copyWith(
                    text: formattedValue,
                    selection: TextSelection.collapsed(
                      offset: formattedValue.length,
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
