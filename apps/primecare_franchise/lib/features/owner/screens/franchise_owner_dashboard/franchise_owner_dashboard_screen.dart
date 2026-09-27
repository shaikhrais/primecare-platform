import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_dashboard_header_section.dart';
import 'sections/franchise_owner_dashboard_summary_cards_section.dart';
import 'sections/franchise_owner_dashboard_chart_overview_section.dart';
import 'sections/franchise_owner_dashboard_recent_activity_section.dart';
import 'sections/franchise_owner_dashboard_quick_actions_section.dart';

class FranchiseOwnerDashboardScreen extends StatelessWidget {
  const FranchiseOwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_dashboard',
      title: 'Franchise Owner Dashboard',
      child: Column(
        children: const [
          const FranchiseOwnerDashboardHeaderSection(),
          const FranchiseOwnerDashboardSummaryCardsSection(),
          const FranchiseOwnerDashboardChartOverviewSection(),
          const FranchiseOwnerDashboardRecentActivitySection(),
          const FranchiseOwnerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
