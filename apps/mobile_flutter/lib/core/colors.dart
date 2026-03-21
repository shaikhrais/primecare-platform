import 'package:flutter/material.dart';
import '../core/colors.dart';


/// The Official PrimeCare Global Color Grading Registry
/// Hardcoded Hex values (Color(0xFF...)) are strictly banned outside this file to prevent UI blunders.
class PrimeCareColors {
  // Deep Background & Surfaces
  static const Color radarDark = PrimeCareColors.radarDark; // Slate 900
  static const Color slate800 = PrimeCareColors.slate800;
  static const Color slate700 = PrimeCareColors.slate700;

  // Core Brand
  static const Color skyBlue = PrimeCareColors.skyBlue; // Primary
  static const Color emerald = PrimeCareColors.emerald; // Success
  static const Color rose = PrimeCareColors.rose; // Critical / Escalate
  static const Color amber = PrimeCareColors.amber; // Warnings

  // Mid-tones & Text
  static const Color slate500 = PrimeCareColors.slate500; // Muted Labels
  static const Color slate400 = PrimeCareColors.slate400; // Standard Subtext
  static const Color slate300 = PrimeCareColors.slate300; // Heavy Subtext
  static const Color slate200 = PrimeCareColors.slate200; // Borders

  // Absolute
  static const Color white = Colors.white; // 0xFFFFFFFF
  static const Color black = Colors.black; // 0xFF000000

  // Misc Rogue Colors mapped from codebase for complete coverage
  static const Color darkMatrix = PrimeCareColors.darkMatrix; // SCM Dashboard Black
  static const Color darkMatrixCard = PrimeCareColors.darkMatrixCard; // B2B Dashboard black
  static const Color purple = PrimeCareColors.purple; // SCM Identity Code
}
