import 'package:flutter/material.dart';

/// Legacy structural fallback to prevent Wasm compiler linkage crashes 
/// across decoupled coordinator and manager dashboards.
class AppTheme {
  static const Color primaryColor = Color(0xFF0F172A);
  static const Color secondaryColor = Color(0xFF3B82F6);
  static const Color successColor = Color(0xFF10B981);
  static const Color dangerColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color background = Color(0xFFF8FAFC);
}
