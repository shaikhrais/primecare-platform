import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operational_efficiency_metrics_header_section.dart';
import 'sections/operational_efficiency_metrics_filter_bar_section.dart';
import 'sections/operational_efficiency_metrics_metrics_summary_section.dart';
import 'sections/operational_efficiency_metrics_chart_area_section.dart';
import 'sections/operational_efficiency_metrics_export_actions_section.dart';

class OperationalEfficiencyMetricsScreen extends StatelessWidget {
  const OperationalEfficiencyMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operational_efficiency_metrics',
      title: 'Operational Efficiency Metrics',
      child: Column(
        children: const [
          const OperationalEfficiencyMetricsHeaderSection(),
          const OperationalEfficiencyMetricsFilterBarSection(),
          const OperationalEfficiencyMetricsMetricsSummarySection(),
          const OperationalEfficiencyMetricsChartAreaSection(),
          const OperationalEfficiencyMetricsExportActionsSection(),
        ],
      ),
    );
  }
}
