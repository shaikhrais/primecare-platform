import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_analytics_header_section.dart';
import 'sections/coo_analytics_filter_bar_section.dart';
import 'sections/coo_analytics_metrics_summary_section.dart';
import 'sections/coo_analytics_chart_area_section.dart';
import 'sections/coo_analytics_export_actions_section.dart';

class CooAnalyticsScreen extends StatelessWidget {
  const CooAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_analytics',
      title: 'CooAnalyticsScreen',
      child: Column(
        children: const [
          const CooAnalyticsHeaderSection(),
          const CooAnalyticsFilterBarSection(),
          const CooAnalyticsMetricsSummarySection(),
          const CooAnalyticsChartAreaSection(),
          const CooAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
