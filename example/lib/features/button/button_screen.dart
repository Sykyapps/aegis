import 'package:aegis/aegis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/navigation/screens.dart';

class ButtonScreen extends HookWidget {
  const ButtonScreen({super.key});

  static const _chipsItem = [100, 200, 300, 400];

  @override
  Widget build(BuildContext context) {
    var selectedChip = useState<String>('');
    return Scaffold(
      appBar: AppBar(title: Text(AegisScreen.button.title)),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkButton(label: 'Active Button', onPressed: () {}),
            SizedBox(height: 12.r),
            const SkButton(label: 'Disabled Button'),
            SizedBox(height: 12.r),
            SkIconButton(
              title: 'Active Icon Button ',
              icon: AegisIcons.check_circle,
              onPressed: () {},
            ),
            SizedBox(height: 12.r),
            const SkIconButton(
              title: 'Disabled Icon Button ',
              icon: AegisIcons.close_circle_fill,
            ),
            SizedBox(height: 12.r),
            SkIconButton.primary(
              icon: AegisIcons.heart,
              title: 'Primary Icon Button',
              onPressed: () {},
            ),
            SizedBox(height: 12.r),
            SkSliderButton(
              onConfirmation: () {},
            ),
            SizedBox(height: 12.r),
            Wrap(
              spacing: 8,
              children: List.generate(_chipsItem.length, (index) {
                var item = _chipsItem[index];
                return SkChoiceChip(
                  label: item.toString(),
                  selected: selectedChip.value == item.toString(),
                  onSelected: () {
                    selectedChip.value = item.toString();
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
