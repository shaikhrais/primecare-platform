import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_dashboard_header_section.dart';
import 'sections/franchise_sales_manager_dashboard_summary_cards_section.dart';
import 'sections/franchise_sales_manager_dashboard_chart_overview_section.dart';
import 'sections/franchise_sales_manager_dashboard_recent_activity_section.dart';
import 'sections/franchise_sales_manager_dashboard_quick_actions_section.dart';

class FranchiseSalesManagerDashboardScreen extends StatelessWidget {
  const FranchiseSalesManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_dashboard',
      title: 'FranchiseSalesManagerDashboardScreen',
      child: Column(
        children: const [
          const FranchiseSalesManagerDashboardHeaderSection(),
          const FranchiseSalesManagerDashboardSummaryCardsSection(),
          const FranchiseSalesManagerDashboardChartOverviewSection(),
          const FranchiseSalesManagerDashboardRecentActivitySection(),
          const FranchiseSalesManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
