import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/guest_analytics_header_section.dart';
import 'sections/guest_analytics_filter_bar_section.dart';
import 'sections/guest_analytics_metrics_summary_section.dart';
import 'sections/guest_analytics_chart_area_section.dart';
import 'sections/guest_analytics_export_actions_section.dart';

class GuestAnalyticsScreen extends StatelessWidget {
  const GuestAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'guest_analytics',
      title: 'GuestAnalyticsScreen',
      child: Column(
        children: const [
          const GuestAnalyticsHeaderSection(),
          const GuestAnalyticsFilterBarSection(),
          const GuestAnalyticsMetricsSummarySection(),
          const GuestAnalyticsChartAreaSection(),
          const GuestAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
