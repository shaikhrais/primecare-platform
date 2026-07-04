import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/business_development_analytics_header_section.dart';
import 'sections/business_development_analytics_filter_bar_section.dart';
import 'sections/business_development_analytics_metrics_summary_section.dart';
import 'sections/business_development_analytics_chart_area_section.dart';
import 'sections/business_development_analytics_export_actions_section.dart';

class BusinessDevelopmentAnalyticsScreen extends StatelessWidget {
  const BusinessDevelopmentAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'business_development_analytics',
      title: 'BusinessDevelopmentAnalyticsScreen',
      child: Column(
        children: const [
          const BusinessDevelopmentAnalyticsHeaderSection(),
          const BusinessDevelopmentAnalyticsFilterBarSection(),
          const BusinessDevelopmentAnalyticsMetricsSummarySection(),
          const BusinessDevelopmentAnalyticsChartAreaSection(),
          const BusinessDevelopmentAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
