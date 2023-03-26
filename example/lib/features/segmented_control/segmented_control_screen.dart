import 'package:aegis_app/core/navigation/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aegis/aegis.dart';

class SegmentedControlScreen extends HookWidget {
  const SegmentedControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var productSegment = useState<int>(0);
    var authSegment = useState<int>(0);
    return Scaffold(
      appBar: AppBar(title: Text(AegisScreen.segmentedControl.title)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkSegmentedControl(
                currentSegment: productSegment.value,
                children: const {
                  0: SkSegmentedControlItem(label: 'Kinerja'),
                  1: SkSegmentedControlItem(label: 'Informasi'),
                  2: SkSegmentedControlItem(label: 'Simulasi'),
                },
                onValueChanged: (value) => productSegment.value = value ?? 0,
              ),
              SizedBox(height: 20.r),
              SkSegmentedControl(
                currentSegment: authSegment.value,
                children: const {
                  0: SkSegmentedControlItem(label: 'Login'),
                  1: SkSegmentedControlItem(label: 'Register'),
                },
                onValueChanged: (value) => authSegment.value = value ?? 0,
              ),
              SizedBox(height: 20.r),
              SkSegmentedControl(
                currentSegment: authSegment.value,
                onValueChanged: (value) => authSegment.value = value ?? 0,
                border: Border.all(color: AegisColors.transparent),
                padding: EdgeInsets.all(8.r),
                children: {
                  0: SkSegmentedControlItem(
                    label: 'Tanpa Target',
                    height: 32.h,
                  ),
                  1: SkSegmentedControlItem(
                    label: 'Set Target',
                    height: 32.h,
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
