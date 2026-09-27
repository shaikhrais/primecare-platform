import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/portal_analytics_header_section.dart';
import 'sections/portal_analytics_filter_bar_section.dart';
import 'sections/portal_analytics_metrics_summary_section.dart';
import 'sections/portal_analytics_chart_area_section.dart';
import 'sections/portal_analytics_export_actions_section.dart';

class PortalAnalyticsScreen extends StatelessWidget {
  const PortalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'portal_analytics',
      title: 'PortalAnalyticsScreen',
      child: Column(
        children: const [
          const PortalAnalyticsHeaderSection(),
          const PortalAnalyticsFilterBarSection(),
          const PortalAnalyticsMetricsSummarySection(),
          const PortalAnalyticsChartAreaSection(),
          const PortalAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
