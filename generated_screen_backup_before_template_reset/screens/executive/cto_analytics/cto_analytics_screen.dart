import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_analytics_header_section.dart';
import 'sections/cto_analytics_filter_bar_section.dart';
import 'sections/cto_analytics_metrics_summary_section.dart';
import 'sections/cto_analytics_chart_area_section.dart';
import 'sections/cto_analytics_export_actions_section.dart';

class CtoAnalyticsScreen extends StatelessWidget {
  const CtoAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_analytics',
      title: 'CtoAnalyticsScreen',
      child: Column(
        children: const [
          const CtoAnalyticsHeaderSection(),
          const CtoAnalyticsFilterBarSection(),
          const CtoAnalyticsMetricsSummarySection(),
          const CtoAnalyticsChartAreaSection(),
          const CtoAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
