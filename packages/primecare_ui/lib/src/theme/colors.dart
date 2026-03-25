import 'package:flutter/material.dart';

/// The Official PrimeCare Global Color Grading Registry
/// Hardcoded Hex values (Color(0xFF...)) are strictly banned outside this file to prevent UI blunders.
class PrimeCareColors {
  // Deep Background & Surfaces
  static const Color radarDark = Color(0xFF0F172A); // Slate 900
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate700 = Color(0xFF334155);

  // Core Brand
  static const Color skyBlue = Color(0xFF38BDF8); // Primary
  static const Color emerald = Color(0xFF10B981); // Success
  static const Color rose = Color(0xFFE11D48); // Critical / Escalate
  static const Color amber = Color(0xFFF59E0B); // Warnings

  // Mid-tones & Text
  static const Color slate500 = Color(0xFF64748B); // Muted Labels
  static const Color slate400 = Color(0xFF94A3B8); // Standard Subtext
  static const Color slate300 = Color(0xFFCBD5E1); // Heavy Subtext
  static const Color slate200 = Color(0xFFE2E8F0); // Borders

  // Absolute
  static const Color white = Color(
    0xFFFFFFFF,
  ); // Explicit instead of Colors.white to avoid recursive node map
  static const Color black = Color(
    0xFF000000,
  ); // Explicit instead of Colors.black

  // Misc Rogue Colors mapped from codebase for complete coverage
  static const Color darkMatrix = Color(0xFF020617); // SCM Home Black
  static const Color darkMatrixCard = Color(0xFF141416); // B2B Home black
  static const Color purple = Color(0xFF8B5CF6); // SCM Identity Code
}
