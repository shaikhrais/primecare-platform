// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/screen_breakpoints.dart';
import '../../config/adaptive_scaling_config.dart';
import '../../providers/zoom_provider.dart';

/// Wraps individual screens to enforce platform-wide typography scaling and padding
/// based on the `AdaptiveScalingConfig` and persistent user-level content zoom.
/// Ensures that 4K screens receive the correct scaling factors and spacing limits.
class ResponsiveScreenWrapper extends ConsumerWidget {
  final Widget child;

  const ResponsiveScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final tier = ScreenBreakpoints.getTier(width);
    
    final double scaleFactor = AdaptiveScalingConfig.getScaleFactor(tier);
    final double spacingMultiplier = AdaptiveScalingConfig.getSpacingMultiplier(tier);

    // Read global user-defined persistent content zoom factor
    final double zoomFactor = ref.watch<double>(contentZoomProvider);

    // Provide standard spacing around the screen content, modified by zoom
    final double padding = 16.0 * spacingMultiplier * zoomFactor;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(scaleFactor * zoomFactor),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
