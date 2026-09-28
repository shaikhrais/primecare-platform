import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_reports_header_section.dart';
import 'sections/customer_support_reports_filter_bar_section.dart';
import 'sections/customer_support_reports_metrics_summary_section.dart';
import 'sections/customer_support_reports_chart_area_section.dart';
import 'sections/customer_support_reports_export_actions_section.dart';

class CustomerSupportReportsScreen extends StatelessWidget {
  const CustomerSupportReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_reports',
      title: 'Customer Support Reports',
      child: Column(
        children: const [
          const CustomerSupportReportsHeaderSection(),
          const CustomerSupportReportsFilterBarSection(),
          const CustomerSupportReportsMetricsSummarySection(),
          const CustomerSupportReportsChartAreaSection(),
          const CustomerSupportReportsExportActionsSection(),
        ],
      ),
    );
  }
}
