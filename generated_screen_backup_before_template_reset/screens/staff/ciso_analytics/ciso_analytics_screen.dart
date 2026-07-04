import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ciso_analytics_header_section.dart';
import 'sections/ciso_analytics_filter_bar_section.dart';
import 'sections/ciso_analytics_metrics_summary_section.dart';
import 'sections/ciso_analytics_chart_area_section.dart';
import 'sections/ciso_analytics_export_actions_section.dart';

class CisoAnalyticsScreen extends StatelessWidget {
  const CisoAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ciso_analytics',
      title: 'CisoAnalyticsScreen',
      child: Column(
        children: const [
          const CisoAnalyticsHeaderSection(),
          const CisoAnalyticsFilterBarSection(),
          const CisoAnalyticsMetricsSummarySection(),
          const CisoAnalyticsChartAreaSection(),
          const CisoAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
