import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_dashboard_header_section.dart';
import 'sections/family_dashboard_summary_cards_section.dart';
import 'sections/family_dashboard_chart_overview_section.dart';
import 'sections/family_dashboard_recent_activity_section.dart';
import 'sections/family_dashboard_quick_actions_section.dart';

class FamilyDashboardScreen extends StatelessWidget {
  const FamilyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_dashboard',
      title: 'Family Dashboard',
      child: Column(
        children: const [
          const FamilyDashboardHeaderSection(),
          const FamilyDashboardSummaryCardsSection(),
          const FamilyDashboardChartOverviewSection(),
          const FamilyDashboardRecentActivitySection(),
          const FamilyDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
