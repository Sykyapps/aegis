import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeasurementUtil {
  static Size measureWidget(Widget widget) {
    PipelineOwner pipelineOwner = PipelineOwner();
    MeasurementView rootView = pipelineOwner.rootNode = MeasurementView();
    BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
    RenderObjectToWidgetElement<RenderBox> element =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: rootView,
      debugShortDescription: '[root]',
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: SizedBox(width: 1.sw, child: widget),
      ),
    ).attachToRenderTree(buildOwner);
    try {
      rootView.scheduleInitialLayout();
      pipelineOwner.flushLayout();
      return rootView.size;
    } finally {
      // Clean up.
      element
          .update(RenderObjectToWidgetAdapter<RenderBox>(container: rootView));
      buildOwner.finalizeTree();
    }
  }
}

class MeasurementView extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    assert(child != null);
    child!.layout(const BoxConstraints(), parentUsesSize: true);
    size = child!.size;
  }

  @override
  void debugAssertDoesMeetConstraints() => true;
}
