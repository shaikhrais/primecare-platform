import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/lpn_analytics_header_section.dart';
import 'sections/lpn_analytics_filter_bar_section.dart';
import 'sections/lpn_analytics_metrics_summary_section.dart';
import 'sections/lpn_analytics_chart_area_section.dart';
import 'sections/lpn_analytics_export_actions_section.dart';

class LpnAnalyticsScreen extends StatelessWidget {
  const LpnAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'lpn_analytics',
      title: 'Licensed Practical Nurse (LPN) Analytics',
      child: Column(
        children: const [
          const LpnAnalyticsHeaderSection(),
          const LpnAnalyticsFilterBarSection(),
          const LpnAnalyticsMetricsSummarySection(),
          const LpnAnalyticsChartAreaSection(),
          const LpnAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
