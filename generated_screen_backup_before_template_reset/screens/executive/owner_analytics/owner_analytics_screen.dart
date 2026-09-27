import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/owner_analytics_header_section.dart';
import 'sections/owner_analytics_filter_bar_section.dart';
import 'sections/owner_analytics_metrics_summary_section.dart';
import 'sections/owner_analytics_chart_area_section.dart';
import 'sections/owner_analytics_export_actions_section.dart';

class OwnerAnalyticsScreen extends StatelessWidget {
  const OwnerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'owner_analytics',
      title: 'OwnerAnalyticsScreen',
      child: Column(
        children: const [
          const OwnerAnalyticsHeaderSection(),
          const OwnerAnalyticsFilterBarSection(),
          const OwnerAnalyticsMetricsSummarySection(),
          const OwnerAnalyticsChartAreaSection(),
          const OwnerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
