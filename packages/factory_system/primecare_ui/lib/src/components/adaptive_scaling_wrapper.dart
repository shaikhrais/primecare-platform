import 'package:flutter/material.dart';
import 'package:primecare_core/flutter_core.dart';

/// A wrapper that dynamically adjusts scaling
/// to implement "Scaling Up" strategy for 3k/4k resolutions.
class AdaptiveScalingWrapper extends StatelessWidget {
  final Widget child;

  const AdaptiveScalingWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final tier = ScreenBreakpoints.getTier(width);
        final scaleFactor = AdaptiveScalingConfig.getScaleFactor(tier);

        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scaleFactor)),
          child: child,
        );
      },
    );
  }
}
