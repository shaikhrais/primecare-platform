import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/lead_analytics_header_section.dart';
import 'sections/lead_analytics_filter_bar_section.dart';
import 'sections/lead_analytics_metrics_summary_section.dart';
import 'sections/lead_analytics_chart_area_section.dart';
import 'sections/lead_analytics_export_actions_section.dart';

class LeadAnalyticsScreen extends StatelessWidget {
  const LeadAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'lead_analytics',
      title: 'LeadAnalyticsScreen',
      child: Column(
        children: const [
          const LeadAnalyticsHeaderSection(),
          const LeadAnalyticsFilterBarSection(),
          const LeadAnalyticsMetricsSummarySection(),
          const LeadAnalyticsChartAreaSection(),
          const LeadAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
