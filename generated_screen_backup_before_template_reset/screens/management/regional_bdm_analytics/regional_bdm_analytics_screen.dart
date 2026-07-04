import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_analytics_header_section.dart';
import 'sections/regional_bdm_analytics_filter_bar_section.dart';
import 'sections/regional_bdm_analytics_metrics_summary_section.dart';
import 'sections/regional_bdm_analytics_chart_area_section.dart';
import 'sections/regional_bdm_analytics_export_actions_section.dart';

class RegionalBdmAnalyticsScreen extends StatelessWidget {
  const RegionalBdmAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_analytics',
      title: 'RegionalBdmAnalyticsScreen',
      child: Column(
        children: const [
          const RegionalBdmAnalyticsHeaderSection(),
          const RegionalBdmAnalyticsFilterBarSection(),
          const RegionalBdmAnalyticsMetricsSummarySection(),
          const RegionalBdmAnalyticsChartAreaSection(),
          const RegionalBdmAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
