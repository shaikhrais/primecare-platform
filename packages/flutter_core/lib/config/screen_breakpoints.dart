// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

enum ResolutionTier {
  /// Mobile (< 600px)
  mob,

  /// Tablet (600px - 1024px)
  tab,

  /// Full HD / Industry Standard Desktop (1024px - 1440px)
  oneK,

  /// Quad HD / High Density Desktop (1440px - 2560px)
  twoK,

  /// Ultra High Density (2560px - 3840px)
  threeK,

  /// 4K resolution (>= 3840px)
  fourK,

  /// Wall-sized / Digital Signage / Institutional display (75"-100"+)
  mega,
}

class ScreenBreakpoints {
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

  static bool isHandheld(BuildContext context) {
    final tier = getTier(MediaQuery.of(context).size.width);
    return tier == ResolutionTier.mob || tier == ResolutionTier.tab;
  }

  static bool isUltraHighRes(BuildContext context) {
    final tier = getTier(MediaQuery.of(context).size.width);
    return tier == ResolutionTier.threeK || tier == ResolutionTier.fourK;
  }
}
