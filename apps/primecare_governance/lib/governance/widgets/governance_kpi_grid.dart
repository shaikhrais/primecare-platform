import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../models/governance_report.dart';

class GovernanceKPIGrid extends StatelessWidget {
  final GovernanceReport report;

  const GovernanceKPIGrid({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 320,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 3.2,
      children: [
        _buildKPI(
          context,
          'Total Screens',
          report.totalScreens.toString(),
          Icons.layers_rounded,
          Colors.blue,
        ),
        _buildKPI(
          context,
          'Total Issues',
          report.totalIssues.toString(),
          Icons.bug_report_rounded,
          Colors.orange,
        ),
        _buildKPI(
          context,
          'Critical Issues',
          report.criticalIssues.toString(),
          Icons.warning_amber_rounded,
          Colors.red,
        ),
        _buildKPI(
          context,
          'Production Ready',
          report.productionReadyScreens.toString(),
          Icons.check_circle_outline_rounded,
          Colors.green,
        ),
        _buildKPI(
          context,
          'Avg. Test Rate',
          '${report.averageTestPassRate.toStringAsFixed(1)}%',
          Icons.fact_check_rounded,
          Colors.purple,
        ),
        _buildKPI(
          context,
          'Render Health',
          '${report.renderOkPercent.toStringAsFixed(1)}%',
          Icons.monitor_heart_rounded,
          Colors.cyan,
        ),
        _buildKPI(
          context,
          'Accessibility',
          '${report.accessibilityPercent.toStringAsFixed(1)}%',
          Icons.accessibility_new_rounded,
          Colors.indigo,
        ),
        _buildKPI(
          context,
          'Performance',
          '${report.performancePercent.toStringAsFixed(1)}%',
          Icons.speed_rounded,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildKPI(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
