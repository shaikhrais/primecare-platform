import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/office_analytics_header_section.dart';
import 'sections/office_analytics_filter_bar_section.dart';
import 'sections/office_analytics_metrics_summary_section.dart';
import 'sections/office_analytics_chart_area_section.dart';
import 'sections/office_analytics_export_actions_section.dart';

class OfficeAnalyticsScreen extends StatelessWidget {
  const OfficeAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'office_analytics',
      title: 'OfficeAnalyticsScreen',
      child: Column(
        children: const [
          const OfficeAnalyticsHeaderSection(),
          const OfficeAnalyticsFilterBarSection(),
          const OfficeAnalyticsMetricsSummarySection(),
          const OfficeAnalyticsChartAreaSection(),
          const OfficeAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
