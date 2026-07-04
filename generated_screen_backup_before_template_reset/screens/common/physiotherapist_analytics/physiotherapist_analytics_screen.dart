import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_analytics_header_section.dart';
import 'sections/physiotherapist_analytics_filter_bar_section.dart';
import 'sections/physiotherapist_analytics_metrics_summary_section.dart';
import 'sections/physiotherapist_analytics_chart_area_section.dart';
import 'sections/physiotherapist_analytics_export_actions_section.dart';

class PhysiotherapistAnalyticsScreen extends StatelessWidget {
  const PhysiotherapistAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_analytics',
      title: 'PhysiotherapistAnalyticsScreen',
      child: Column(
        children: const [
          const PhysiotherapistAnalyticsHeaderSection(),
          const PhysiotherapistAnalyticsFilterBarSection(),
          const PhysiotherapistAnalyticsMetricsSummarySection(),
          const PhysiotherapistAnalyticsChartAreaSection(),
          const PhysiotherapistAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
