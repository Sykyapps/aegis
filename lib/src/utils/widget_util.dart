import 'dart:io';

import 'package:flutter/material.dart';

extension WidgetUtil on BuildContext {
  double get bottomPadding {
    var bottom = MediaQuery.paddingOf(this).bottom;
    if (Platform.isAndroid || (Platform.isIOS && bottom == 0)) bottom += 16;
    return bottom;
  }
}
