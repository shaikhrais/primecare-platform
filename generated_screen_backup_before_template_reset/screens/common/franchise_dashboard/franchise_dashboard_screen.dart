import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_dashboard_header_section.dart';
import 'sections/franchise_dashboard_summary_cards_section.dart';
import 'sections/franchise_dashboard_chart_overview_section.dart';
import 'sections/franchise_dashboard_recent_activity_section.dart';
import 'sections/franchise_dashboard_quick_actions_section.dart';

class FranchiseDashboardScreen extends StatelessWidget {
  const FranchiseDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_dashboard',
      title: 'FranchiseDashboardScreen',
      child: Column(
        children: const [
          const FranchiseDashboardHeaderSection(),
          const FranchiseDashboardSummaryCardsSection(),
          const FranchiseDashboardChartOverviewSection(),
          const FranchiseDashboardRecentActivitySection(),
          const FranchiseDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
