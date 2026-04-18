import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import '../../components/dashboards/prime_care_kpi_card.dart';
import '../../components/dashboards/prime_care_responsive_kpi_grid.dart';
import '../../components/charts/prime_care_bar_chart.dart';
import '../../components/charts/prime_care_line_chart.dart';
import '../../components/charts/prime_care_pie_chart.dart';
import '../stitch_engine/stitch_screen_widget.dart';

/// A factory-style widget that translates [UIComponentBlueprint] entities into high-fidelity UI components.
class BlueprintRenderer extends StatelessWidget {
  final UIComponentBlueprint blueprint;

  const BlueprintRenderer({super.key, required this.blueprint});

  @override
  Widget build(BuildContext context) {
    switch (blueprint.componentType) {
      case 'stat_card_grid':
        return _buildStatGrid(blueprint as StatGridBlueprint);
      case 'stitch_screen':
        return StitchScreenWidget(
          screenId: (blueprint as StitchBlueprint).screenId,
        );
      case 'analytics_chart':
        return _buildChart(blueprint as ChartBlueprint);
      default:
        // Default to placeholder if unknown
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: PrimeCareColors.rose.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: PrimeCareColors.rose.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            'Unknown Blueprint: ${blueprint.componentType}',
            style: const TextStyle(
              color: PrimeCareColors.rose,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }

  Widget _buildStatGrid(StatGridBlueprint blueprint) {
    final kpis = blueprint.dataPayload as List<UniversalKpi>;
    return PrimeCareResponsiveKpiGrid(
      children: kpis
          .map((kpi) {
            return PrimeCareKpiCard(
              title: kpi.title,
              value: kpi.value,
              subtitle:
                  '${kpi.trend >= 0 ? '+' : ''}${kpi.trend}% vs last month',
              icon: _getIconForMetric(kpi.title),
              onPinToggle: () {},
            );
          })
          .toList()
          .cast<Widget>(),
    );
  }

  Widget _buildChart(ChartBlueprint blueprint) {
    final chartData = blueprint.dataPayload;
    // Assuming the payload matches the AnalyticsChart structure
    if (chartData is AnalyticsChart) {
      switch (chartData.type) {
        case ChartType.line:
          return PrimeCareLineChart(chart: chartData);
        case ChartType.bar:
          return PrimeCareBarChart(chart: chartData);
        case ChartType.pie:
          return PrimeCarePieChart(chart: chartData);
      }
    }
    return const SizedBox.shrink();
  }

  Color? _mapStatus(KpiStatus status) {
    switch (status) {
      case KpiStatus.positive:
        return PrimeCareColors.emerald;
      case KpiStatus.negative:
        return PrimeCareColors.rose;
      case KpiStatus.warning:
        return PrimeCareColors.amber;
      case KpiStatus.critical:
        return PrimeCareColors.rose;
      case KpiStatus.neutral:
        return PrimeCareColors.skyBlue;
    }
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient')) return Icons.people;
    if (t.contains('revenue') || t.contains('dollar'))
      return Icons.attach_money;
    if (t.contains('capacity')) return Icons.pie_chart;
    if (t.contains('alert') || t.contains('risk'))
      return Icons.warning_amber_rounded;
    return Icons.insights;
  }
}
