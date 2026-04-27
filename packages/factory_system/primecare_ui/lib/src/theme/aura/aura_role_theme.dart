// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/theme.dart';

/// AuraRoleTheme: Defines high-fidelity visual tokens (gradients, pulses, accents)
/// mapped to specific platform roles for the "Aura Series" UI.
class AuraRoleTheme {
  final List<Color> primaryGradient;
  final List<Color> secondaryGradient;
  final Color accentColor;
  final Color pulseColor;
  final String auraLabel;

  const AuraRoleTheme({
    required this.primaryGradient,
    required this.secondaryGradient,
    required this.accentColor,
    required this.pulseColor,
    required this.auraLabel,
  });

  /// Resolves the AuraRoleTheme based on the current platform role.
  factory AuraRoleTheme.of(String? role) {
    switch (role?.toLowerCase()) {
      case 'finance director':
      case 'finance_director':
        return const AuraRoleTheme(
          primaryGradient: [
            Color(0xFFFFD700),
            Color(0xFFDAA520),
          ], // Gold / Goldenrod
          secondaryGradient: [
            Color(0xFFB8860B),
            Color(0xFF8B4513),
          ], // Dark Gold / Saddle Brown
          accentColor: Color(0xFFFFD700),
          pulseColor: Color(0xFFFFD700),
          auraLabel: 'FINANCE INTELLIGENCE',
        );
      case 'operations manager':
      case 'operations_manager':
        return const AuraRoleTheme(
          primaryGradient: [
            Color(0xFF00BFFF),
            Color(0xFF1E90FF),
          ], // DeepSkyBlue / DodgerBlue
          secondaryGradient: [
            Color(0xFF4169E1),
            Color(0xFF00008B),
          ], // RoyalBlue / DarkBlue
          accentColor: Color(0xFF00BFFF),
          pulseColor: Color(0xFF00BFFF),
          auraLabel: 'OPS OPTIMIZATION',
        );
      case 'clinical director':
      case 'clinical_director':
        return const AuraRoleTheme(
          primaryGradient: [
            Color(0xFF00FA9A),
            Color(0xFF3CB371),
          ], // MediumSpringGreen / MediumSeaGreen
          secondaryGradient: [
            Color(0xFF2E8B57),
            Color(0xFF006400),
          ], // SeaGreen / DarkGreen
          accentColor: Color(0xFF00FA9A),
          pulseColor: Color(0xFF00FA9A),
          auraLabel: 'CLINICAL INSIGHTS',
        );
      case 'training director':
      case 'training_director':
        return const AuraRoleTheme(
          primaryGradient: [
            Color(0xFFFF69B4),
            Color(0xFFFF1493),
          ], // HotPink / DeepPink
          secondaryGradient: [
            Color(0xFFC71585),
            Color(0xFF800080),
          ], // MediumVioletRed / Purple
          accentColor: Color(0xFFFF69B4),
          pulseColor: Color(0xFFFF69B4),
          auraLabel: 'ACADEMY ANALYTICS',
        );
      case 'cto':
      case 'chief technology officer':
        return const AuraRoleTheme(
          primaryGradient: [
            Color(0xFF00FFCC),
            Color(0xFF0099FF),
          ], // Neon Cyan / Electric Blue
          secondaryGradient: [
            Color(0xFF0B1325),
            Color(0xFF1C2541),
          ], // Obsidian / Dark Navy
          accentColor: Color(0xFF00FFCC),
          pulseColor: Color(0xFF00FFCC),
          auraLabel: 'COMMAND HORIZON',
        );
      default:
        return const AuraRoleTheme(
          primaryGradient: [PrimeCareColors.sapphire, PrimeCareColors.skyBlue],
          secondaryGradient: [PrimeCareColors.navy, PrimeCareColors.sapphire],
          accentColor: PrimeCareColors.sapphire,
          pulseColor: PrimeCareColors.sapphire,
          auraLabel: 'AURA INTELLIGENCE',
        );
    }
  }

  /// Helper to get theme from context via AuthProvider.
  static AuraRoleTheme resolve(WidgetRef ref) {
    final role = ref.watch(authProvider).role;
    return AuraRoleTheme.of(role);
  }
}
