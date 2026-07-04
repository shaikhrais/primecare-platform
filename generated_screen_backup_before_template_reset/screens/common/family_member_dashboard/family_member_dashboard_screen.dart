import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_dashboard_header_section.dart';
import 'sections/family_member_dashboard_summary_cards_section.dart';
import 'sections/family_member_dashboard_chart_overview_section.dart';
import 'sections/family_member_dashboard_recent_activity_section.dart';
import 'sections/family_member_dashboard_quick_actions_section.dart';

class FamilyMemberDashboardScreen extends StatelessWidget {
  const FamilyMemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_dashboard',
      title: 'FamilyMemberDashboardScreen',
      child: Column(
        children: const [
          const FamilyMemberDashboardHeaderSection(),
          const FamilyMemberDashboardSummaryCardsSection(),
          const FamilyMemberDashboardChartOverviewSection(),
          const FamilyMemberDashboardRecentActivitySection(),
          const FamilyMemberDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
