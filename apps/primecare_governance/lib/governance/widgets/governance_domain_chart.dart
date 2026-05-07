import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/governance_report.dart';
import '../models/governance_category.dart';

class GovernanceDomainChart extends StatelessWidget {
  final GovernanceReport report;

  const GovernanceDomainChart({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final categoryCounts = <GovernanceCategory, int>{};
    for (final issue in report.issues) {
      categoryCounts[issue.category] =
          (categoryCounts[issue.category] ?? 0) + 1;
    }

    final data = categoryCounts.entries.map((e) {
      return PieChartSectionData(
        value: e.value.toDouble(),
        title: '${e.key.name.toUpperCase()}\n${e.value}',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        color: _getCategoryColor(e.key),
      );
    }).toList();

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
            'Issue Distribution by Category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 300,
            child: PieChart(
              PieChartData(
                sections: data.isEmpty
                    ? [
                        PieChartSectionData(
                          value: 1,
                          title: 'No Issues',
                          color: Colors.grey,
                        ),
                      ]
                    : data,
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(GovernanceCategory category) {
    switch (category) {
      case GovernanceCategory.audit:
        return Colors.blue;
      case GovernanceCategory.render:
        return Colors.pink;
      case GovernanceCategory.routing:
        return Colors.orange;
      case GovernanceCategory.rbac:
        return Colors.red;
      case GovernanceCategory.lifecycle:
        return Colors.green;
      case GovernanceCategory.component:
        return Colors.purple;
      case GovernanceCategory.testing:
        return Colors.indigo;
      case GovernanceCategory.accessibility:
        return Colors.teal;
      case GovernanceCategory.performance:
        return Colors.cyan;
      case GovernanceCategory.security:
        return Colors.amber;
      case GovernanceCategory.production:
        return Colors.deepOrange;
      case GovernanceCategory.ownership:
        return Colors.grey;
      case GovernanceCategory.compliance:
        return Colors.brown;
      case GovernanceCategory.api:
        return Colors.blueGrey;
      case GovernanceCategory.data:
        return Colors.lime;
      case GovernanceCategory.localization:
        return Colors.lightBlue;
      case GovernanceCategory.responsive:
        return Colors.deepPurple;
    }
  }
}
