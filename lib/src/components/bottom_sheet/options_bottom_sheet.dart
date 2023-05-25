import 'package:aegis/components.dart';
import 'package:aegis/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkOptionsBottomSheet<T> extends HookWidget {
  const SkOptionsBottomSheet({
    super.key,
    required this.title,
    required this.initial,
    required this.options,
    required this.getName,
  });

  final String title;
  final T? initial;
  final List<T> options;
  final String Function(T) getName;

  Future<T?> show(BuildContext context) {
    var result = SkExpandableBottomSheet.show<T>(
      context,
      title: title,
      isExpandable: false,
      child: this,
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var selected = useState<T?>(initial);
    return Material(
      color: AegisColors.backgroundWhite,
      child: Column(
        children: options
            .map((option) => _OptionItem(
                  name: getName(option),
                  isActive: selected.value == option,
                  onSelected: () {
                    selected.value = option;
                    Navigator.of(context).pop(selected.value);
                  },
                ))
            .toList(),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    Key? key,
    required this.name,
    required this.onSelected,
    this.isActive = false,
  }) : super(key: key);

  final String name;
  final bool isActive;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        height: 56.r,
        width: 1.sw,
        margin: const EdgeInsets.symmetric(horizontal: 20).r,
        padding: const EdgeInsets.symmetric(vertical: 16).r,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AegisColors.borderHighEmphasis),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                name,
                style: AegisFont.bodyMedium.copyWith(
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            const SkCheckbox(),
          ],
        ),
      ),
    );
  }
}
