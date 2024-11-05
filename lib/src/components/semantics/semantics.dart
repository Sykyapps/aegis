import 'package:flutter/material.dart';

class SkSemantics extends StatelessWidget {
  const SkSemantics({
    super.key,
    this.identifier,
    this.label,
    this.excludeSemantics = false,
    required this.child,
  });

  final String? identifier;
  final String? label;
  final bool excludeSemantics;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: identifier == null,
      excludeSemantics: excludeSemantics,
      container: true,
      identifier: identifier,
      label: label,
      child: child,
    );
  }
}
