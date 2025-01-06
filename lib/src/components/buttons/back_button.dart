import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../icons.dart';

class SkBackButton extends StatelessWidget {
  const SkBackButton({Key? key, this.onPressed}) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SkSemantics(
      identifier: 'back_button',
      excludeSemantics: true,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(AegisIcons.chevron_left),
      ),
    );
  }
}
