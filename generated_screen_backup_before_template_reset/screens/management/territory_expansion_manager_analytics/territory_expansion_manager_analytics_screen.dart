import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_analytics_header_section.dart';
import 'sections/territory_expansion_manager_analytics_filter_bar_section.dart';
import 'sections/territory_expansion_manager_analytics_metrics_summary_section.dart';
import 'sections/territory_expansion_manager_analytics_chart_area_section.dart';
import 'sections/territory_expansion_manager_analytics_export_actions_section.dart';

class TerritoryExpansionManagerAnalyticsScreen extends StatelessWidget {
  const TerritoryExpansionManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_analytics',
      title: 'TerritoryExpansionManagerAnalyticsScreen',
      child: Column(
        children: const [
          const TerritoryExpansionManagerAnalyticsHeaderSection(),
          const TerritoryExpansionManagerAnalyticsFilterBarSection(),
          const TerritoryExpansionManagerAnalyticsMetricsSummarySection(),
          const TerritoryExpansionManagerAnalyticsChartAreaSection(),
          const TerritoryExpansionManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
