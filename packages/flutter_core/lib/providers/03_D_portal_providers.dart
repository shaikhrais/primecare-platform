// Layer: 03_DATA_DOMAIN_LOGIC
import '../01_I_auth_service.dart';
import '../config/01_I_navigation_registry.dart';
import '../models/01_I_navigation_item.dart';
import '../config/01_I_screen_breakpoints.dart';
import '../config/01_I_adaptive_scaling_config.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:flutter/widgets.dart';

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
      menu.length > 0 &&
      menu == NavigationRegistry.getMenuForRole('Admin')) {
    ref
        .read<ExecutionGateService>(executionGateProvider)
        .failGate(
          ExecutionGateCategory.navigationLayer,
          'navigation_fallback_warning: Fallback to Admin for role $role',
        );
  }

  Future.microtask(() {
    ref
        .read<ExecutionGateService>(executionGateProvider)
        .passGate(
          ExecutionGateCategory.navigationLayer,
          'Hydrated ${menu.length} navigation items for role: $role',
        );
  });

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

enum SidebarMode { hidden, minimal, extended }

/// Model for resolution-aware layout properties.
class LayoutConfig {
  final ResolutionTier tier;
  final double scaleFactor;
  final double sidebarWidth;
  final double spacingMultiplier;
  final SidebarMode sidebarMode;
  final int totalColumns;
  final int sidebarColumns;
  final double screenWidth;

  const LayoutConfig({
    required this.tier,
    required this.scaleFactor,
    required this.sidebarWidth,
    required this.spacingMultiplier,
    this.sidebarMode = SidebarMode.extended,
    this.totalColumns = 12,
    this.sidebarColumns = 2,
    this.screenWidth = 1024,
  });

  bool get isExtended => sidebarMode == SidebarMode.extended;
  bool get isMinimal => sidebarMode == SidebarMode.minimal;
  bool get isHidden => sidebarMode == SidebarMode.hidden;

  /// The width of a single unit in the current grid system.
  double get gridUnitWidth => screenWidth / totalColumns;

  factory LayoutConfig.fromWidth(
    double width, {
    double? pixelRatio,
    SidebarMode mode = SidebarMode.extended,
  }) {
    final tier = ScreenBreakpoints.getTier(width, pixelRatio: pixelRatio);
    final totalCols = AdaptiveScalingConfig.getGridColumns(tier);

    // Dynamic sidebar column span based on mode
    int sidebarCols = 0;
    if (mode == SidebarMode.extended) {
      sidebarCols = AdaptiveScalingConfig.getSidebarSpan(tier);
    } else if (mode == SidebarMode.minimal) {
      sidebarCols = AdaptiveScalingConfig.getMinimalSidebarSpan(tier);
    }

    // Force fixed pixel width to match the ResponsiveShell's rendering
    double calculatedSidebarWidth = 0;
    if (mode == SidebarMode.extended) {
      calculatedSidebarWidth = AdaptiveScalingConfig.getSidebarWidth(tier);
    } else if (mode == SidebarMode.minimal) {
      calculatedSidebarWidth = AdaptiveScalingConfig.getMinimalSidebarWidth(
        tier,
      );
    } else {
      calculatedSidebarWidth = 0;
    }

    return LayoutConfig(
      tier: tier,
      scaleFactor: AdaptiveScalingConfig.getScaleFactor(tier),
      sidebarWidth: calculatedSidebarWidth,
      spacingMultiplier: AdaptiveScalingConfig.getSpacingMultiplier(tier),
      sidebarMode: mode,
      totalColumns: totalCols,
      sidebarColumns: sidebarCols,
      screenWidth: width,
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

/// Notifier for the user override of sidebar mode.
class SidebarOverrideNotifier extends Notifier<SidebarMode?> {
  @override
  SidebarMode? build() => null;

  void setMode(SidebarMode mode) => state = mode;
}

/// Provider for the user override of sidebar mode.
final sidebarOverrideProvider =
    NotifierProvider<SidebarOverrideNotifier, SidebarMode?>(
      SidebarOverrideNotifier.new,
    );

/// Provider for the sidebar mode (toggled by user or system).
final sidebarModeProvider = Provider<SidebarMode>((ref) {
  final override = ref.watch(sidebarOverrideProvider);
  if (override != null) return override;

  final metrics = ref.watch(screenMetricsProvider);
  if (metrics == null) return SidebarMode.extended;

  final tier = ScreenBreakpoints.getTier(
    metrics.size.width,
    pixelRatio: metrics.devicePixelRatio,
  );

  // Default to hidden for mobile/tablet, extended otherwise
  if (tier == ResolutionTier.mob || tier == ResolutionTier.tab) {
    return SidebarMode.hidden;
  }
  return SidebarMode.extended;
});

/// Master layout provider that supplies density-aware configuration.
final layoutProvider = Provider<LayoutConfig>((ref) {
  final data = ref.watch(screenMetricsProvider);
  final mode = ref.watch(sidebarModeProvider);

  if (data == null) {
    return LayoutConfig.fromWidth(1024, mode: mode);
  }
  return LayoutConfig.fromWidth(
    data.size.width,
    pixelRatio: data.devicePixelRatio,
    mode: mode,
  );
});
