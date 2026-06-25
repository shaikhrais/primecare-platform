// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE Wraps individual screens to enforce platform-wide typography scaling and padding based on th...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/screen_breakpoints.dart';
import '../../config/adaptive_scaling_config.dart';
import '../../providers/zoom_provider.dart';

import 'package:go_router/go_router.dart';

/// Wraps individual screens to enforce platform-wide typography scaling and padding
/// based on the `AdaptiveScalingConfig` and persistent user-level content zoom.
/// Ensures that 4K screens receive the correct scaling factors and spacing limits.
class ResponsiveScreenWrapper extends ConsumerWidget {
  final Widget child;

  const ResponsiveScreenWrapper({super.key, required this.child});

  /// Static builder injected by primecare_ui at startup to overlay dev/admin diagnostics.
  static Widget Function(BuildContext context, String routePath, Widget child)? overlayBuilder;

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

    Widget mainWidget = child;
    if (overlayBuilder != null) {
      String routePath = '';
      try {
        routePath = GoRouterState.of(context).uri.path;
      } catch (_) {}
      mainWidget = overlayBuilder!(context, routePath, child);
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(scaleFactor * zoomFactor),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: mainWidget,
      ),
    );
  }
}
