import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_analytics_header_section.dart';
import 'sections/rpn_analytics_filter_bar_section.dart';
import 'sections/rpn_analytics_metrics_summary_section.dart';
import 'sections/rpn_analytics_chart_area_section.dart';
import 'sections/rpn_analytics_export_actions_section.dart';

class RpnAnalyticsScreen extends StatelessWidget {
  const RpnAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_analytics',
      title: 'RpnAnalyticsScreen',
      child: Column(
        children: const [
          const RpnAnalyticsHeaderSection(),
          const RpnAnalyticsFilterBarSection(),
          const RpnAnalyticsMetricsSummarySection(),
          const RpnAnalyticsChartAreaSection(),
          const RpnAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
