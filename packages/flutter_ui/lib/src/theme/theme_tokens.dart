import 'package:flutter/material.dart';

/// Enterprise Mathematical Base Grid (4-pt System)
class PrimeCareSpacing {
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double giant = 64.0;

  // Semantic Shortcuts for Edge Padding
  static const EdgeInsets edgeAllMd = EdgeInsets.all(md);
  static const EdgeInsets edgeAllLg = EdgeInsets.all(lg);
  static const EdgeInsets edgeScreen = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
}

/// Enterprise Curvature Metrics
class PrimeCareRadii {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double rounded = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double pill = 999.0;

  static final BorderRadius boardSm = BorderRadius.circular(sm);
  static final BorderRadius boardMd = BorderRadius.circular(md);
  static final BorderRadius boardRounded = BorderRadius.circular(rounded);
  static final BorderRadius boardLg = BorderRadius.circular(lg);
  static final BorderRadius boardXl = BorderRadius.circular(xl);
  static final BorderRadius boardPill = BorderRadius.circular(pill);
}

/// Enterprise Physical Depth Simulator (Soft Shadow Vectors)
class PrimeCareShadows {
  static const BoxShadow soft = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 16,
    spreadRadius: 2,
    offset: Offset(0, 4),
  );

  static const BoxShadow floating = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 32,
    spreadRadius: 8,
    offset: Offset(0, 16),
  );

  static const BoxShadow dangerGlow = BoxShadow(
    color: Color(0x33E11D48),
    blurRadius: 16,
    offset: Offset(0, 4),
  );
}

/// Animation Vectors
class PrimeCareDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration regular = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);
}
