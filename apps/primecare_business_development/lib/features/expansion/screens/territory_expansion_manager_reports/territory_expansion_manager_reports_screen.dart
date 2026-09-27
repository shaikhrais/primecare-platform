import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_reports_header_section.dart';
import 'sections/territory_expansion_manager_reports_filter_bar_section.dart';
import 'sections/territory_expansion_manager_reports_metrics_summary_section.dart';
import 'sections/territory_expansion_manager_reports_chart_area_section.dart';
import 'sections/territory_expansion_manager_reports_export_actions_section.dart';

class TerritoryExpansionManagerReportsScreen extends StatelessWidget {
  const TerritoryExpansionManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_reports',
      title: 'Territory Expansion Manager Reports',
      child: Column(
        children: const [
          const TerritoryExpansionManagerReportsHeaderSection(),
          const TerritoryExpansionManagerReportsFilterBarSection(),
          const TerritoryExpansionManagerReportsMetricsSummarySection(),
          const TerritoryExpansionManagerReportsChartAreaSection(),
          const TerritoryExpansionManagerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
