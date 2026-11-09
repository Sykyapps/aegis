import 'dart:core';
import 'dart:developer';

import 'package:aegis/components.dart';
import 'package:aegis/foundation.dart';
import 'package:aegis/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetScreen extends HookWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedNumbers = useValueNotifier<List<String>>([]);

    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheet')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkButton(
              label: 'Basic Bottom Sheet',
              onPressed: () {
                SkExpandableBottomSheet.show(
                  context,
                  title: 'Basic Bottom Sheet Panjang Banget',
                  isExpandable: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      4,
                      (index) => SkButton(label: '$index'),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            SkButton(
              label: 'Bottom Sheet tanpa header',
              onPressed: () async {
                await const SkBottomSheet(
                  showHeader: false,
                  padding: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Sheet tanpa header'),
                        SizedBox(height: 8),
                        Text('Cocok untuk sheet bergaya dialog.'),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ).show(context);
              },
            ),
            const SizedBox(height: 8),
            SkButton(
              label: 'Bottom Sheet dengan bottom bar',
              onPressed: () async {
                var result = await SkBottomSheet<String>(
                  title: 'Bottom Bar',
                  bottomBar: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: SkButton(
                      label: 'Pilih',
                      onPressed: () => Navigator.of(context).pop('dipilih'),
                    ),
                  ),
                  child: const SizedBox(
                    height: 400,
                    child: Center(
                      child: Text('Konten yang bisa di-scroll'),
                    ),
                  ),
                ).show(context);

                log('Hasil sheet: $result');
              },
            ),
            const SizedBox(height: 8),
            SkButton(
              label: 'Tap to open Scrollable Bottom Sheet',
              onPressed: () async {
                log('Button pressed');

                await SkBottomSheet(
                  title: 'Title',
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        color: AegisColors.purple100,
                      ),
                      const TextField(),
                      Container(
                        height: 1000,
                        color: AegisColors.purple200,
                      ),
                    ],
                  ),
                ).show(context);
              },
            ),
            const SizedBox(height: 8),
            SkButton(
              label: 'Tap to open Searchable Bottom Sheet',
              onPressed: () async {
                log('Button pressed');

                await SkSearchableOptionsBottomSheet<PhoneNumber>(
                  title: 'Undang Teman',
                  searchHint: 'Cari nama kontak ataupun nomor ponsel',
                  emptyTitle: 'Kontak Tidak Ditemukan',
                  emptyDescription:
                      'Coba periksa atau ganti kata kunci yang ingin kamu cari.',
                  options: const [
                    PhoneNumber('Calvin Andhika', '0822993344'),
                    PhoneNumber('Dalvin Andhika', '0822993345'),
                    PhoneNumber('Ealvin Andhika', '0822993346'),
                    PhoneNumber('Falvin Andhika', '0822993347'),
                    PhoneNumber('Galvin Andhika', '0822993348'),
                    PhoneNumber('Halvin Andhika', '0822993349'),
                  ],
                  groupByAlphabet: true,
                  getLabel: (p0) => p0.name,
                  getImage: (p0) => '',
                  subtitleBuilder: (p0, _) => const SizedBox(),
                  selectedItems: selectedNumbers,
                  trailingBuilder: (p0, _) {
                    void addPhone(bool add) {
                      List<String> temp = List.from(selectedNumbers.value);
                      add ? temp.add(p0.phone) : temp.remove(p0.phone);
                      selectedNumbers.value = temp;
                    }

                    //TODO: filter if the phone number is already invited
                    if (p0.phone == '0822993344') {
                      return _Button.isInvited();
                    } else if (selectedNumbers.value.contains(p0.phone)) {
                      return _Button(
                        isSelected: true,
                        onTap: () {
                          addPhone(false);
                        },
                      );
                    } else {
                      return _Button(
                        isSelected: false,
                        onTap: () {
                          addPhone(true);
                        },
                      );
                    }
                  },
                  actionButton: const _ActionButton(),
                  trailing: Container(
                    padding: const EdgeInsets.all(10),
                    color: AegisColors.red300,
                    child: Text(
                      'Trailing Widget',
                      style: AegisFont.bodyMedium.copyWith(
                        color: AegisColors.neutral0,
                      ),
                    ),
                  ),
                ).show(context);

                selectedNumbers.value = [];
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneNumber {
  final String name;
  final String phone;

  const PhoneNumber(this.name, this.phone);
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          color: AegisColors.neutral100,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Text(
            '1 dari 10 diundang',
            style: AegisFont.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          color: AegisColors.neutral0,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: SkButton(
            label: 'Undang',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    this.isSelected = false,
    this.isInvited = false,
    this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final bool isInvited;
  final VoidCallback? onTap;

  factory _Button.isInvited() => const _Button(isInvited: true);

  @override
  Widget build(BuildContext context) {
    return isInvited
        ? SkIconButton(
            width: 100,
            title: 'Diundang',
            iconSize: 17,
            textStyle: AegisFont.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: AegisColors.neutral300,
            ),
            foregroundColor: AegisColors.neutral300,
            backgroundColor: AegisColors.neutral0,
            border: const BorderSide(color: AegisColors.neutral200),
            icon: AegisIcons.check,
            onPressed: () {
              onTap?.call();
            },
          )
        : isSelected
            ? SkIconButton(
                width: 100,
                title: 'Batal',
                iconSize: 17,
                textStyle: AegisFont.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AegisColors.red300,
                ),
                foregroundColor: AegisColors.red300,
                backgroundColor: AegisColors.red100,
                border: const BorderSide(color: AegisColors.red100),
                icon: AegisIcons.close,
                onPressed: () {
                  onTap?.call();
                },
              )
            : SkIconButton(
                width: 100,
                title: 'Undang',
                iconSize: 17,
                textStyle: AegisFont.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AegisColors.purple300,
                ),
                border: const BorderSide(color: AegisColors.purple100),
                foregroundColor: AegisColors.purple300,
                backgroundColor: AegisColors.purple100,
                icon: AegisIcons.add,
                onPressed: () {
                  onTap?.call();
                },
              );
  }
}
