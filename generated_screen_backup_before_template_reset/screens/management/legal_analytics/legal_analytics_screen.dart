import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/legal_analytics_header_section.dart';
import 'sections/legal_analytics_filter_bar_section.dart';
import 'sections/legal_analytics_metrics_summary_section.dart';
import 'sections/legal_analytics_chart_area_section.dart';
import 'sections/legal_analytics_export_actions_section.dart';

class LegalAnalyticsScreen extends StatelessWidget {
  const LegalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'legal_analytics',
      title: 'LegalAnalyticsScreen',
      child: Column(
        children: const [
          const LegalAnalyticsHeaderSection(),
          const LegalAnalyticsFilterBarSection(),
          const LegalAnalyticsMetricsSummarySection(),
          const LegalAnalyticsChartAreaSection(),
          const LegalAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
