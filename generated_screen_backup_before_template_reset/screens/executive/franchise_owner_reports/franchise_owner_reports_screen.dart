import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_reports_header_section.dart';
import 'sections/franchise_owner_reports_filter_bar_section.dart';
import 'sections/franchise_owner_reports_metrics_summary_section.dart';
import 'sections/franchise_owner_reports_chart_area_section.dart';
import 'sections/franchise_owner_reports_export_actions_section.dart';

class FranchiseOwnerReportsScreen extends StatelessWidget {
  const FranchiseOwnerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_reports',
      title: 'FranchiseOwnerReportsScreen',
      child: Column(
        children: const [
          const FranchiseOwnerReportsHeaderSection(),
          const FranchiseOwnerReportsFilterBarSection(),
          const FranchiseOwnerReportsMetricsSummarySection(),
          const FranchiseOwnerReportsChartAreaSection(),
          const FranchiseOwnerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
