import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_manager_usa_analytics_header_section.dart';
import 'sections/regional_manager_usa_analytics_filter_bar_section.dart';
import 'sections/regional_manager_usa_analytics_metrics_summary_section.dart';
import 'sections/regional_manager_usa_analytics_chart_area_section.dart';
import 'sections/regional_manager_usa_analytics_export_actions_section.dart';

class RegionalManagerUsaAnalyticsScreen extends StatelessWidget {
  const RegionalManagerUsaAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_manager_usa_analytics',
      title: 'RegionalManagerUsaAnalyticsScreen',
      child: Column(
        children: const [
          const RegionalManagerUsaAnalyticsHeaderSection(),
          const RegionalManagerUsaAnalyticsFilterBarSection(),
          const RegionalManagerUsaAnalyticsMetricsSummarySection(),
          const RegionalManagerUsaAnalyticsChartAreaSection(),
          const RegionalManagerUsaAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
