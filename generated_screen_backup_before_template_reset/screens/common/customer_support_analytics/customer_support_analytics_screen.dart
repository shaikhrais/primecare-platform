import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_analytics_header_section.dart';
import 'sections/customer_support_analytics_filter_bar_section.dart';
import 'sections/customer_support_analytics_metrics_summary_section.dart';
import 'sections/customer_support_analytics_chart_area_section.dart';
import 'sections/customer_support_analytics_export_actions_section.dart';

class CustomerSupportAnalyticsScreen extends StatelessWidget {
  const CustomerSupportAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_analytics',
      title: 'CustomerSupportAnalyticsScreen',
      child: Column(
        children: const [
          const CustomerSupportAnalyticsHeaderSection(),
          const CustomerSupportAnalyticsFilterBarSection(),
          const CustomerSupportAnalyticsMetricsSummarySection(),
          const CustomerSupportAnalyticsChartAreaSection(),
          const CustomerSupportAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
