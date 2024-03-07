import 'package:aegis/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../checkboxes/checkbox.dart';
import 'fields.dart';

class SkOptionField<T> extends HookWidget {
  const SkOptionField({
    super.key,
    this.enabled = true,
    required this.controller,
    required this.labelText,
    this.initial,
    required this.options,
    required this.getName,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.readOnly = false,
  });

  final bool enabled;
  final TextEditingController controller;
  final String labelText;
  final T? initial;
  final List<T> options;
  final String Function(T) getName;
  final FormFieldValidator<String>? validator;
  final void Function(T)? onChanged;
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    var selected = useState<T?>(initial);
    var width = (MediaQuery.of(context).size.width / options.length) * 0.8;

    useEffect(() {
      selected.value ??= initial;
      return;
    }, [initial]);

    return Focus(
      focusNode: focusNode,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          IgnorePointer(
            child: SkTextField(
              enabled: enabled,
              controller: controller,
              labelText: labelText,
              validator: validator,
              readOnly: readOnly,
            ),
          ),
          Positioned(
            top: 30,
            child: Container(
              color: AegisColors.backgroundWhite,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: options
                    .map((option) => _OptionItem(
                          isActive: selected.value == option,
                          width: width,
                          label: getName(option),
                          onPressed: !enabled
                              ? null
                              : () {
                                  selected.value = option;
                                  onChanged?.call(option);
                                },
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    Key? key,
    this.isActive = false,
    required this.label,
    this.onPressed,
    required this.width,
  }) : super(key: key);

  final bool isActive;
  final double width;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var enabled = onPressed != null;
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: width,
        child: Row(
          children: [
            SkCheckbox(isActive: isActive, isDisabled: !enabled),
            SizedBox(width: 8.r),
            Text(
              label,
              style: AegisFont.bodyLarge.copyWith(
                color:
                    enabled ? AegisColors.neutral500 : AegisColors.neutral300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
