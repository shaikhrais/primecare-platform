import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_admin_analytics_header_section.dart';
import 'sections/billing_admin_analytics_filter_bar_section.dart';
import 'sections/billing_admin_analytics_metrics_summary_section.dart';
import 'sections/billing_admin_analytics_chart_area_section.dart';
import 'sections/billing_admin_analytics_export_actions_section.dart';

class BillingAdminAnalyticsScreen extends StatelessWidget {
  const BillingAdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_admin_analytics',
      title: 'BillingAdminAnalyticsScreen',
      child: Column(
        children: const [
          const BillingAdminAnalyticsHeaderSection(),
          const BillingAdminAnalyticsFilterBarSection(),
          const BillingAdminAnalyticsMetricsSummarySection(),
          const BillingAdminAnalyticsChartAreaSection(),
          const BillingAdminAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
