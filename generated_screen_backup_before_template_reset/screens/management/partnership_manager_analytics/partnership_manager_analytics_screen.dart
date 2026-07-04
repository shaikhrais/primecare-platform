import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_analytics_header_section.dart';
import 'sections/partnership_manager_analytics_filter_bar_section.dart';
import 'sections/partnership_manager_analytics_metrics_summary_section.dart';
import 'sections/partnership_manager_analytics_chart_area_section.dart';
import 'sections/partnership_manager_analytics_export_actions_section.dart';

class PartnershipManagerAnalyticsScreen extends StatelessWidget {
  const PartnershipManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_analytics',
      title: 'PartnershipManagerAnalyticsScreen',
      child: Column(
        children: const [
          const PartnershipManagerAnalyticsHeaderSection(),
          const PartnershipManagerAnalyticsFilterBarSection(),
          const PartnershipManagerAnalyticsMetricsSummarySection(),
          const PartnershipManagerAnalyticsChartAreaSection(),
          const PartnershipManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
