import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';
import '../config/navigation_registry.dart';
import '../models/navigation_item.dart';
import '../config/screen_breakpoints.dart';
import '../config/adaptive_scaling_config.dart';
import 'package:flutter/widgets.dart';

/// Provider that supplies the navigation menu items for the current user's role.
final navigationMenuProvider = Provider<List<PrimeCareNavigationItem>>((ref) {
  final authState = ref.watch(authProvider);
  final role = authState.role ?? 'PSW';
  return NavigationRegistry.getMenuForRole(role);
});

/// Provider for portal-specific configuration.
final portalConfigProvider = Provider<PortalConfig>((ref) {
  final authState = ref.watch(authProvider);
  final role = authState.role ?? 'PSW';
  
  return PortalConfig(
    title: '${role.toUpperCase()} Portal',
    brandingName: 'PrimeCare Classic',
    isPlain: true,
  );
});

class PortalConfig {
  final String title;
  final String brandingName;
  final bool isPlain;

  const PortalConfig({
    required this.title,
    required this.brandingName,
    this.isPlain = true,
  });
}

/// Model for resolution-aware layout properties.
class LayoutConfig {
  final ResolutionTier tier;
  final double scaleFactor;
  final double sidebarWidth;
  final double spacingMultiplier;
  final bool isExtended;

  const LayoutConfig({
    required this.tier,
    required this.scaleFactor,
    required this.sidebarWidth,
    required this.spacingMultiplier,
    this.isExtended = true,
  });

  factory LayoutConfig.fromWidth(double width, {double? pixelRatio}) {
    final tier = ScreenBreakpoints.getTier(width, pixelRatio: pixelRatio);
    return LayoutConfig(
      tier: tier,
      scaleFactor: AdaptiveScalingConfig.getScaleFactor(tier),
      sidebarWidth: AdaptiveScalingConfig.getSidebarWidth(tier),
      spacingMultiplier: AdaptiveScalingConfig.getSpacingMultiplier(tier),
      isExtended: tier != ResolutionTier.mob && 
                  tier != ResolutionTier.tab && 
                  tier != ResolutionTier.oneK,
    );
  }
}

/// Notifier for the screen size and metrics.
class ScreenMetricsNotifier extends Notifier<MediaQueryData?> {
  @override
  MediaQueryData? build() => null;

  set state(MediaQueryData? value) => super.state = value;
}

/// Provider for the screen size. This should be updated by the root widget.
final screenMetricsProvider = NotifierProvider<ScreenMetricsNotifier, MediaQueryData?>(ScreenMetricsNotifier.new);

/// Master layout provider that supplies density-aware configuration.
final layoutProvider = Provider<LayoutConfig>((ref) {
  final data = ref.watch(screenMetricsProvider);
  if (data == null) {
    // Return a safe default for pre-load/test scenarios
    return LayoutConfig.fromWidth(1024);
  }
  return LayoutConfig.fromWidth(
    data.size.width,
    pixelRatio: data.devicePixelRatio,
  );
});
