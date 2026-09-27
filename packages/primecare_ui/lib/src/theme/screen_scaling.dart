// Governance - Category: view | Purpose: Utility class to handle high-fidelity responsive scaling from a 4K design canvas (3840x2160). This ensures that 4K de...
import 'package:flutter/material.dart';

/// Utility class to handle high-fidelity responsive scaling from a 4K design canvas (3840x2160).
/// This ensures that 4K designs look premium on ultra-wide displays while remaining
/// perfectly responsive on 3K, 2K, 1K, Tablet, and Mobile viewports.
class ScreenScaling {
  /// The base design width for high-fidelity assets (4K).
  static const double designWidth = 3840.0;

  /// The base design height for high-fidelity assets (4K).
  static const double designHeight = 2160.0;

  final BuildContext context;

  ScreenScaling(this.context);

  /// Current screen size.
  Size get screenSize => MediaQuery.of(context).size;

  /// Calculate the scale factor relative to the 4K design width.
  double get scaleFactor => screenSize.width / designWidth;

  /// Scales a specific value (dimension, font size, etc.) from 4K design space
  /// to the current viewport scale.
  double scale(double value) => value * scaleFactor;

  /// Device classification based on width.
  bool get is4K => screenSize.width >= 3840;
  bool get is3K => screenSize.width >= 3000 && screenSize.width < 3840;
  bool get is2K => screenSize.width >= 2000 && screenSize.width < 3000;
  bool get is1K => screenSize.width >= 1000 && screenSize.width < 2000;

  bool get isDesktop => screenSize.width >= 1200;
  bool get isTablet => screenSize.width >= 600 && screenSize.width < 1200;
  bool get isMobile => screenSize.width < 600;

  /// Returns a responsive value based on the device tier.
  T responsiveValue<T>({
    required T default4K,
    T? desktop,
    T? tablet,
    T? mobile,
  }) {
    if (isMobile && mobile != null) return mobile;
    if (isTablet && tablet != null) return tablet;
    if (isDesktop && desktop != null) return desktop;
    return default4K;
  }
}

/// Extension to provide easy access to scaling from BuildContext.
extension ScreenScalingExtension on BuildContext {
  ScreenScaling get scaling => ScreenScaling(this);

  /// Quick scaling helper.
  double s(double value) => scaling.scale(value);
}
