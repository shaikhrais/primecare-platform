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

  /// Returns target sidebar width for the given tier.
  static double getSidebarWidth(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.mega:
        return 480.0;
      case ResolutionTier.fourK:
        return 320.0;
      case ResolutionTier.threeK:
        return 280.0;
      default:
        return 240.0;
    }
  }
}
