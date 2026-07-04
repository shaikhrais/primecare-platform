import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_dashboard_header_section.dart';
import 'sections/partnership_manager_dashboard_summary_cards_section.dart';
import 'sections/partnership_manager_dashboard_chart_overview_section.dart';
import 'sections/partnership_manager_dashboard_recent_activity_section.dart';
import 'sections/partnership_manager_dashboard_quick_actions_section.dart';

class PartnershipManagerDashboardScreen extends StatelessWidget {
  const PartnershipManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_dashboard',
      title: 'PartnershipManagerDashboardScreen',
      child: Column(
        children: const [
          const PartnershipManagerDashboardHeaderSection(),
          const PartnershipManagerDashboardSummaryCardsSection(),
          const PartnershipManagerDashboardChartOverviewSection(),
          const PartnershipManagerDashboardRecentActivitySection(),
          const PartnershipManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
