import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:flutter_core/theme/prime_semantic_palette.dart';
// Governance - Category: view | Purpose: Core implementation file for the Governance Master Score platform logic.
import 'package:primecare_ui/primecare_ui.dart' show PrimeCircularProgressIndicator;
import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';
import '../models/governance_report.dart';

class GovernanceMasterScore extends StatelessWidget {
  final GovernanceReport report;

  const GovernanceMasterScore({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final score = report.overallHealthScore;
    final color = _getScoreColor(context, score);

    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 32,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: PrimeCircularProgressIndicator(
              value: score / 100,
              strokeWidth: 12,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimeText(
                '${score.toInt()}%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: readableThemeForeground(Theme.of(context).colorScheme.surface, color),
                ),
              ),
              PrimeText(
                'HEALTH SCORE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: PrimeSemanticPalette.tint(context, color, alpha: .1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PrimeText(
                  _getScoreLabel(score),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: PrimeSemanticPalette.onTint(context, color, alpha: .1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(BuildContext context, double score) {
    if (score >= 90) return PrimeSemanticPalette.of(context, PrimeSemanticTone.success).accent;
    if (score >= 75) return PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent;
    if (score >= 50) return PrimeSemanticPalette.of(context, PrimeSemanticTone.warning).accent;
    return PrimeSemanticPalette.of(context, PrimeSemanticTone.error).accent;
  }

  String _getScoreLabel(double score) {
    if (score >= 90) return 'EXCELLENT';
    if (score >= 75) return 'GOOD';
    if (score >= 50) return 'WARNING';
    return 'CRITICAL';
  }
}
