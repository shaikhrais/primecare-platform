import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/finance_director_analytics_header_section.dart';
import 'sections/finance_director_analytics_filter_bar_section.dart';
import 'sections/finance_director_analytics_metrics_summary_section.dart';
import 'sections/finance_director_analytics_chart_area_section.dart';
import 'sections/finance_director_analytics_export_actions_section.dart';

class FinanceDirectorAnalyticsScreen extends StatelessWidget {
  const FinanceDirectorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'finance_director_analytics',
      title: 'FinanceDirectorAnalyticsScreen',
      child: Column(
        children: const [
          const FinanceDirectorAnalyticsHeaderSection(),
          const FinanceDirectorAnalyticsFilterBarSection(),
          const FinanceDirectorAnalyticsMetricsSummarySection(),
          const FinanceDirectorAnalyticsChartAreaSection(),
          const FinanceDirectorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
