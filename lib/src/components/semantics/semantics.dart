import 'package:flutter/material.dart';

class SkSemantics extends StatelessWidget {
  const SkSemantics({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      container: true,
      label: label,
      child: child,
    );
  }
}
