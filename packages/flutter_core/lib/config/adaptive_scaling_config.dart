import 'screen_breakpoints.dart';

class AdaptiveScalingConfig {
  /// Returns the text scale factor based on the resolution tier.
  static double getScaleFactor(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.threeK:
        return 1.25;
      case ResolutionTier.fourK:
        return 1.5;
      default:
        return 1.0;
    }
  }

  /// Returns the relative spacing multiplier for high resolution screens.
  static double getSpacingMultiplier(ResolutionTier tier) {
    switch (tier) {
      case ResolutionTier.fourK:
        return 1.4;
      case ResolutionTier.threeK:
        return 1.2;
      default:
        return 1.0;
    }
  }
}
