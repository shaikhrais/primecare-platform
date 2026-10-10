import 'resolution_tier.dart';
import 'screen_breakpoint_policy.dart';
import 'adaptive_scaling_config.dart';

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
    final tier = ScreenBreakpointPolicy.getTier(width, pixelRatio: pixelRatio);
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
