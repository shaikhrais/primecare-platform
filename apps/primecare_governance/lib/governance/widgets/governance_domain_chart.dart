import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
// Governance - Category: view | Purpose: Core implementation file for the Governance Domain Chart platform logic.
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_core/flutter_core.dart';
import '../models/governance_report.dart';

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
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: readableThemeForeground(_getCategoryColor(context, e.key), context.theme.colors.onSurface),
        ),
        color: _getCategoryColor(context, e.key),
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.theme.colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimeText(
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
                          color: context.theme.colors.surfaceContainerHigh,
                          titleStyle: TextStyle(color: readableThemeForeground(context.theme.colors.surfaceContainerHigh, context.theme.colors.onSurface)),
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

  Color _getCategoryColor(BuildContext context, GovernanceCategory category) {
    switch (category) {
      case GovernanceCategory.audit:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.render:
        return PrimeActionPalette.of(context, PrimeActionTone.secondary).accent;
      case GovernanceCategory.routing:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.rbac:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.lifecycle:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.component:
        return PrimeActionPalette.of(context, PrimeActionTone.secondary).accent;
      case GovernanceCategory.testing:
        return PrimeActionPalette.of(context, PrimeActionTone.secondary).accent;
      case GovernanceCategory.accessibility:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.performance:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.security:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.production:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.ownership:
        return context.theme.colors.surfaceContainerHigh;
      case GovernanceCategory.compliance:
        return PrimeActionPalette.of(context, PrimeActionTone.secondary).accent;
      case GovernanceCategory.api:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.data:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.localization:
        return PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
      case GovernanceCategory.responsive:
        return PrimeActionPalette.of(context, PrimeActionTone.secondary).accent;
    }
  }
}
