// Layer: 02_COMPONENTS
import 'package:flutter/material.dart';

/// Standard breakpoints for the PrimeCare platform.
class PrimeCareBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
}

/// A responsive layout widget that selects the appropriate child based on screen width.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// Helper to check if the current screen is mobile.
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < PrimeCareBreakpoints.mobile;

  /// Helper to check if the current screen is tablet.
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= PrimeCareBreakpoints.mobile &&
      MediaQuery.sizeOf(context).width < PrimeCareBreakpoints.tablet;

  /// Helper to check if the current screen is desktop.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= PrimeCareBreakpoints.tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= PrimeCareBreakpoints.tablet) {
          return desktop;
        } else if (constraints.maxWidth >= PrimeCareBreakpoints.mobile) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
