import 'package:flutter/material.dart';

class PrimeCareTheme {
  static final colors = _PrimeCareColors();
  static final typography = _PrimeCareTypography();
}

class _PrimeCareColors {
  final navyIndigo = const Color(0xFF5654A8);
  final emeraldTeal = const Color(0xFF006948);
  final slateGray = const Color(0xFF6D7A72);
  final surfaceContainerHighest = const Color(0xFFE0E3E5);
  final surfaceContainerHigh = const Color(0xFFF2F4F6);
  final surfaceContainerLow = const Color(0xFFFAFBFC);
  final coralRed = const Color(0xFFBA1A1A);
  final amberWarning = const Color(0xFFFF9800);
}

class _PrimeCareTypography {
  final heroTitle = const TextStyle(
    fontFamily: 'Outfit',
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  
  final h2 = const TextStyle(
    fontFamily: 'Outfit',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  final h3 = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  final body = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
  );

  final label = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
  );
}
