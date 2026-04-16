import 'screen_breakpoints.dart';

class AdaptiveScalingConfig {
  /// Returns the text scale factor based on the resolution tier.
  static double getScaleFactor(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.mega:
        return 3.0; // Extreme scaling for wall displays
      case ResolutionTier.fourK:
        return 1.5;
      case ResolutionTier.threeK:
        return 1.25;
      case ResolutionTier.twoK:
        return 1.1;
      default:
        return 1.0;
    }
  }

  /// Returns the relative spacing multiplier for high resolution screens.
  static double getSpacingMultiplier(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.mega:
        return 2.5;
      case ResolutionTier.fourK:
        return 1.4;
      case ResolutionTier.threeK:
        return 1.2;
      default:
        return 1.0;
    }
  }

  /// Returns the target column count for the grid system based on the tier.
  static int getGridColumns(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.mega:
        return 24;
      case ResolutionTier.threeK:
      case ResolutionTier.fourK:
        return 20;
      case ResolutionTier.twoK:
        return 16;
      case ResolutionTier.oneK:
        return 12;
      case ResolutionTier.tab:
        return 8;
      case ResolutionTier.mob:
        return 4;
    }
  }

  /// Returns the column span for the sidebar based on the tier.
  static int getSidebarSpan(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.mega:
      case ResolutionTier.fourK:
      case ResolutionTier.threeK:
        return 4;
      case ResolutionTier.twoK:
        return 3;
      case ResolutionTier.oneK:
        return 2;
      default:
        return 0; // Drawer/Hidden modes
    }
  }

  /// Returns the minimal (collapsed) column span for the sidebar.
  static int getMinimalSidebarSpan(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.mega:
      case ResolutionTier.fourK:
      case ResolutionTier.threeK:
      case ResolutionTier.twoK:
        return 2;
      case ResolutionTier.oneK:
        return 1;
      default:
        return 0;
    }
  }

  /// Returns target sidebar width for the given tier (Legacy/Drawer support).
  static double getSidebarWidth(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.mega:
        return 480.0;
      case ResolutionTier.fourK:
        return 320.0;
      case ResolutionTier.threeK:
        return 280.0;
      default:
        return 260.0;
    }
  }
}
