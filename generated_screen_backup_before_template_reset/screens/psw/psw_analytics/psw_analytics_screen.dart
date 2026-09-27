import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_analytics_header_section.dart';
import 'sections/psw_analytics_filter_bar_section.dart';
import 'sections/psw_analytics_metrics_summary_section.dart';
import 'sections/psw_analytics_chart_area_section.dart';
import 'sections/psw_analytics_export_actions_section.dart';

class PswAnalyticsScreen extends StatelessWidget {
  const PswAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_analytics',
      title: 'Psw Analytics',
      child: Column(
        children: const [
          const PswAnalyticsHeaderSection(),
          const PswAnalyticsFilterBarSection(),
          const PswAnalyticsMetricsSummarySection(),
          const PswAnalyticsChartAreaSection(),
          const PswAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
