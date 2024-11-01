import 'package:flutter/material.dart';

class SkSemantics extends StatelessWidget {
  const SkSemantics({
    super.key,
    this.identifier,
    this.label,
    required this.child,
  });

  final String? identifier;
  final String? label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: identifier == null,
      container: true,
      identifier: identifier,
      label: label,
      child: child,
    );
  }
}
