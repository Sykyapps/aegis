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
    this.itemBuilder,
    this.isScrollable = false,
  });

  final String title;
  final T? initial;
  final List<T> options;
  final String Function(T) getName;
  final Widget Function(T, bool)? itemBuilder;
  final bool isScrollable;

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
    if (isScrollable) {
      return Material(
        color: AegisColors.backgroundWhite,
        child: SingleChildScrollView(
          child: Column(
            children: options.map((option) {
              return GestureDetector(
                onTap: () {
                  selected.value = option;
                  if (itemBuilder != null) return;
                  Navigator.of(context).pop(selected.value);
                },
                child: itemBuilder?.call(option, selected.value == option) ??
                    _OptionItem(
                      name: getName(option),
                      isActive: selected.value == option,
                    ),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Material(
      color: AegisColors.backgroundWhite,
      child: Column(
        children: options.map((option) {
          return GestureDetector(
            onTap: () {
              selected.value = option;
              if (itemBuilder != null) return;
              Navigator.of(context).pop(selected.value);
            },
            child: itemBuilder?.call(option, selected.value == option) ??
                _OptionItem(
                  name: getName(option),
                  isActive: selected.value == option,
                ),
          );
        }).toList(),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    Key? key,
    required this.name,
    this.isActive = false,
  }) : super(key: key);

  final String name;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: const EdgeInsets.symmetric(horizontal: 20).r,
      padding: const EdgeInsets.symmetric(vertical: 16).r,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AegisColors.borderHighEmphasis),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: AegisFont.bodyMedium.copyWith(
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          SkCheckbox(isActive: isActive),
        ],
      ),
    );
  }
}
