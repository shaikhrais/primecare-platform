import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_ui/src/theme/colors.dart';

/// A high-fidelity Aura annotation component for data visualizations.
/// Surfaces intelligent trends and AI-driven insights directly in-line with charts.
class AuraTrendIndicator extends StatelessWidget {
  final double value;
  final String label;
  final String insight;
  final bool isPositiveBetter;
  final VoidCallback? onTap;

  const AuraTrendIndicator({
    super.key,
    required this.value,
    required this.label,
    required this.insight,
    this.isPositiveBetter = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = value >= 0;
    final isGood = isPositiveBetter ? isPositive : !isPositive;

    final color = isGood ? const Color(0xFF4ADE80) : const Color(0xFFF87171);
    final icon = isPositive ? LucideIcons.trendingUp : LucideIcons.trendingDown;

    return Tooltip(
      richMessage: TextSpan(
        children: [
          TextSpan(
            text: 'Aura Insight: ',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: PrimeCareColors.white,
            ),
          ),
          TextSpan(
            text: insight,
            style: GoogleFonts.inter(color: PrimeCareColors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                '${isPositive ? '+' : ''}${value.toStringAsFixed(1)}%',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 1,
                height: 12,
                color: color.withValues(alpha: 0.3),
              ),
              const SizedBox(width: 8),
              const Icon(
                LucideIcons.sparkles,
                size: 10,
                color: Color(0xFF818CF8), // Aura indigo
              ),
            ],
          ),
        ),
      ),
    );
  }
}
