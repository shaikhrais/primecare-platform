import 'resolution_tier.dart';

class ScreenBreakpointPolicy {
  static const double mobileMax = 768;
  static const double tabletMax = 1024;
  static const double oneKMax = 1440;
  static const double twoKMax = 2560;
  static const double threeKMax = 3840;

  static ResolutionTier getTier(double width, {double? pixelRatio}) {
    // Explicit Mega check for Wallboards / Extreme Displays (>= 5120px)
    if (width >= 5120 || (width >= 3840 && (pixelRatio ?? 1.0) >= 4.0)) {
      return ResolutionTier.mega;
    }

    if (width < mobileMax) return ResolutionTier.mob;
    if (width < tabletMax) return ResolutionTier.tab;
    if (width < oneKMax) return ResolutionTier.oneK;
    if (width < twoKMax) return ResolutionTier.twoK;
    if (width < threeKMax) return ResolutionTier.threeK;
    return ResolutionTier.fourK;
  }
}
