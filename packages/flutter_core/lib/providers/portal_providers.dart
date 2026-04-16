import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';
import '../config/navigation_registry.dart';
import '../models/navigation_item.dart';
import '../config/screen_breakpoints.dart';
import '../config/adaptive_scaling_config.dart';
import '../telemetry_service.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../routes/groups/common_routes.dart';

/// Provider that supplies the navigation menu items for the current user's role.
final navigationMenuProvider = Provider<List<PrimeCareNavigationItem>>((ref) {
  final authState = ref.watch(authProvider);
  final role = authState.role ?? 'PSW';
  final menu = List<PrimeCareNavigationItem>.from(
    NavigationRegistry.getMenuForRole(role),
  );

  // Diagnostic Telemetry: Detect if we fell back to Admin unexpectedly
  if (role != 'Admin' &&
      role != 'CEO' &&
      menu == NavigationRegistry.getMenuForRole('Admin')) {
    ref
        .read(executionGateProvider)
        .failGate(
          ExecutionGateCategory.navigationLayer,
          'navigation_fallback_warning: Fallback to Admin for role $role',
        );
  }

  // Inject Common Tools for all users dynamically, except for routes they already have.
  final commonItems = [
    const PrimeCareNavigationItem(
      label: 'Messaging Hub',
      icon: LucideIcons.messageSquare,
      route: CommonRoutes.messagingHub,
      section: 'Common Tools',
    ),
    const PrimeCareNavigationItem(
      label: 'Document Vault',
      icon: LucideIcons.folder,
      route: CommonRoutes.documentVault,
      section: 'Common Tools',
    ),
    const PrimeCareNavigationItem(
      label: 'Notifications',
      icon: LucideIcons.bell,
      route: CommonRoutes.notificationCenter,
      section: 'Common Tools',
    ),
    const PrimeCareNavigationItem(
      label: 'Global Settings',
      icon: LucideIcons.settings,
      route: CommonRoutes.globalSettings,
      section: 'Common Tools',
    ),
  ];

  for (var commonItem in commonItems) {
    if (!menu.any((item) => item.route == commonItem.route)) {
      menu.add(commonItem);
    }
  }

  ref
      .read(executionGateProvider)
      .passGate(
        ExecutionGateCategory.navigationLayer,
        'Hydrated ${menu.length} navigation items for role: $role',
      );

  debugPrint('--- [DEBUG] HYDRATED SIDEBAR MENU FOR ROLE: $role ---');
  for (var item in menu) {
    debugPrint(' - [${item.section}] ${item.label} -> ${item.route}');
  }
  debugPrint('-----------------------------------------------------');

  return menu;
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
      isExtended:
          tier != ResolutionTier.mob &&
          tier != ResolutionTier.tab &&
          tier != ResolutionTier.oneK,
    );
  }
}

/// Notifier for the screen size and metrics.
class ScreenMetricsNotifier extends Notifier<MediaQueryData?> {
  @override
  MediaQueryData? build() => null;

  @override
  set state(MediaQueryData? value) => super.state = value;
}

/// Provider for the screen size. This should be updated by the root widget.
final screenMetricsProvider =
    NotifierProvider<ScreenMetricsNotifier, MediaQueryData?>(
      ScreenMetricsNotifier.new,
    );

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
