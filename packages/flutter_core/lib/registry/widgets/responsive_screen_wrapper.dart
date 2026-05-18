// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import '../../config/screen_breakpoints.dart';
import '../../config/adaptive_scaling_config.dart';

/// Wraps individual screens to enforce platform-wide typography scaling and padding
/// based on the `AdaptiveScalingConfig`. Ensures that 4K screens receive the correct
/// scaling factors and spacing limits.
class ResponsiveScreenWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final tier = ScreenBreakpoints.getTier(width);
    
    final scaleFactor = AdaptiveScalingConfig.getScaleFactor(tier);
    final spacingMultiplier = AdaptiveScalingConfig.getSpacingMultiplier(tier);

    // Provide standard spacing around the screen content
    final padding = 16.0 * spacingMultiplier;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(scaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
