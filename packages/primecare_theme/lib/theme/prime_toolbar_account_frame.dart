import 'package:flutter/material.dart';

import 'prime_shell_metrics.dart';

/// Shared frame for the compact toolbar account trigger.
class PrimeToolbarAccountFrame extends StatelessWidget {
  const PrimeToolbarAccountFrame({
    super.key,
    this.radius = PrimeShellMetrics.toolbarAccountRadius,
    required this.child,
  });

  final BorderRadius radius;
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: PrimeShellMetrics.toolbarAccountDecoration(
      Theme.of(context),
      radius: radius,
    ),
    child: child,
  );
}
