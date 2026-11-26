import 'package:flutter_core/theme/prime_semantic_palette.dart';
// Governance - Category: view | Purpose: Core implementation file for the Governance Compliance Checklist platform logic.
// unnecessary import removed
import 'package:primecare_ui/primecare_ui.dart' show PrimeIcon;
import '../models/governance_report.dart';
import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter_core/flutter_core.dart';

class GovernanceComplianceChecklist extends StatelessWidget {
  final GovernanceReport report;

  const GovernanceComplianceChecklist({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimeText(
            'Platform Compliance Scorecard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCheckItem(context,
            'Architectural Parity (Render/A11y/Perf)',
            report.renderOkPercent > 90 &&
                report.accessibilityPercent > 90 &&
                report.performancePercent > 90,
            'All screens must pass 90% threshold for core vitals.',
          ),
          _buildCheckItem(context,
            'Production Readiness',
            report.blockedScreens == 0,
            'Zero critical or high issues allowed in production-bound features.',
          ),
          _buildCheckItem(context,
            'Test Quality Gate',
            report.averageTestPassRate >= 95.0,
            'Platform-wide average test pass rate must be >= 95%.',
          ),
          _buildCheckItem(context,
            'Security Baseline',
            report.issues
                .where((i) => i.category == GovernanceCategory.security)
                .isEmpty,
            'No unresolved security drifts detected.',
          ),
          _buildCheckItem(context,
            'Documentation Integrity',
            report.issues
                .where((i) => i.category == GovernanceCategory.audit)
                .isEmpty,
            'All screens must have sourcePath and assigned owners.',
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(BuildContext context, String title, bool isPassed, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          PrimeIcon(
            isPassed ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
            color: isPassed ? PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onBase : PrimeSemanticPalette.of(context, PrimeSemanticTone.warning).onBase,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeText(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isPassed ? null : PrimeSemanticPalette.of(context, PrimeSemanticTone.warning).onBase,
                  ),
                ),
                PrimeText(
                  description,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          if (isPassed)
            PrimeText(
              'PASSED',
              style: TextStyle(
                color: PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onBase,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            )
          else
            PrimeText(
              'FAILED',
              style: TextStyle(
                color: PrimeSemanticPalette.of(context, PrimeSemanticTone.warning).onBase,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }
}
