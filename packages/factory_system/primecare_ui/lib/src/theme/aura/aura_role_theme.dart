// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

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
      case 'administrator':
      case 'it admin':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFF64748B), Color(0xFF475569)], // Slate
          secondaryGradient: [Color(0xFF334155), Color(0xFF1E293B)],
          accentColor: Color(0xFF94A3B8),
          pulseColor: Color(0xFF64748B),
          auraLabel: 'SYSTEM ADMINISTRATION',
        );
      case 'auditor':
      case 'compliance manager':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFF8B5CF6), Color(0xFF7C3AED)], // Violet
          secondaryGradient: [Color(0xFF6D28D9), Color(0xFF5B21B6)],
          accentColor: Color(0xFFA78BFA),
          pulseColor: Color(0xFF8B5CF6),
          auraLabel: 'GOVERNANCE AUDIT',
        );
      case 'finance director':
      case 'cfo':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFFFACC15), Color(0xFFEAB308)], // Yellow
          secondaryGradient: [Color(0xFFCA8A04), Color(0xFFA16207)],
          accentColor: Color(0xFFFACC15),
          pulseColor: Color(0xFFEAB308),
          auraLabel: 'FISCAL INTELLIGENCE',
        );
      case 'operations manager':
      case 'coo':
      case 'regional manager':
      case 'coordinator':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFF38BDF8), Color(0xFF0EA5E9)], // Sky
          secondaryGradient: [Color(0xFF0284C7), Color(0xFF0369A1)],
          accentColor: Color(0xFF38BDF8),
          pulseColor: Color(0xFF0EA5E9),
          auraLabel: 'OPERATIONAL RADAR',
        );
      case 'clinical director':
      case 'rn':
      case 'psw':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFF34D399), Color(0xFF10B981)], // Emerald
          secondaryGradient: [Color(0xFF059669), Color(0xFF047857)],
          accentColor: Color(0xFF34D399),
          pulseColor: Color(0xFF10B981),
          auraLabel: 'CLINICAL ATELIER',
        );
      case 'training director':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFFF472B6), Color(0xFFEC4899)], // Pink
          secondaryGradient: [Color(0xFFDB2777), Color(0xFFBE185D)],
          accentColor: Color(0xFFF472B6),
          pulseColor: Color(0xFFEC4899),
          auraLabel: 'ACADEMY ANALYTICS',
        );
      case 'cto':
      case 'developer':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFF22D3EE), Color(0xFF06B6D4)], // Cyan
          secondaryGradient: [Color(0xFF0891B2), Color(0xFF0E7490)],
          accentColor: Color(0xFF22D3EE),
          pulseColor: Color(0xFF06B6D4),
          auraLabel: 'COMMAND HORIZON',
        );
      case 'ceo':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFFF87171), Color(0xFFEF4444)], // Red
          secondaryGradient: [Color(0xFFDC2626), Color(0xFFB91C1C)],
          accentColor: Color(0xFFF87171),
          pulseColor: Color(0xFFEF4444),
          auraLabel: 'ENTERPRISE VORTEX',
        );
      case 'cx director':
      case 'head of marketing':
      case 'family':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFFFB923C), Color(0xFFF97316)], // Orange
          secondaryGradient: [Color(0xFFEA580C), Color(0xFFC2410C)],
          accentColor: Color(0xFFFB923C),
          pulseColor: Color(0xFFF97316),
          auraLabel: 'EXPERIENCE PULSE',
        );
      case 'product manager':
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFF818CF8), Color(0xFF6366F1)], // Indigo
          secondaryGradient: [Color(0xFF4F46E5), Color(0xFF4338CA)],
          accentColor: Color(0xFF818CF8),
          pulseColor: Color(0xFF6366F1),
          auraLabel: 'STRATEGY MAP',
        );
      default:
        return const AuraRoleTheme(
          primaryGradient: [Color(0xFF6366F1), Color(0xFF4F46E5)], // Indigo
          secondaryGradient: [Color(0xFF4338CA), Color(0xFF3730A3)],
          accentColor: Color(0xFF6366F1),
          pulseColor: Color(0xFF4F46E5),
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
