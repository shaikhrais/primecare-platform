// unnecessary import removed
import '../models/governance_report.dart';
import 'package:flutter_core/flutter_core.dart';

class GovernanceComplianceChecklist extends StatelessWidget {
  final GovernanceReport report;

  const GovernanceComplianceChecklist({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Platform Compliance Scorecard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCheckItem(
            'Architectural Parity (Render/A11y/Perf)',
            report.renderOkPercent > 90 &&
                report.accessibilityPercent > 90 &&
                report.performancePercent > 90,
            'All screens must pass 90% threshold for core vitals.',
          ),
          _buildCheckItem(
            'Production Readiness',
            report.blockedScreens == 0,
            'Zero critical or high issues allowed in production-bound features.',
          ),
          _buildCheckItem(
            'Test Quality Gate',
            report.averageTestPassRate >= 95.0,
            'Platform-wide average test pass rate must be >= 95%.',
          ),
          _buildCheckItem(
            'Security Baseline',
            report.issues
                .where((i) => i.category == GovernanceCategory.security)
                .isEmpty,
            'No unresolved security drifts detected.',
          ),
          _buildCheckItem(
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

  Widget _buildCheckItem(String title, bool isPassed, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            isPassed ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
            color: isPassed ? Colors.green : Colors.orange,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isPassed ? null : Colors.orange,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (isPassed)
            const Text(
              'PASSED',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            )
          else
            const Text(
              'FAILED',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }
}
