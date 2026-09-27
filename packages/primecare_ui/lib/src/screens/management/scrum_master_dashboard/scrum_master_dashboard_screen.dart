import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scrum_master_dashboard_header_section.dart';
import 'sections/scrum_master_dashboard_summary_cards_section.dart';
import 'sections/scrum_master_dashboard_chart_overview_section.dart';
import 'sections/scrum_master_dashboard_recent_activity_section.dart';
import 'sections/scrum_master_dashboard_quick_actions_section.dart';

class ScrumMasterDashboardScreen extends StatelessWidget {
  const ScrumMasterDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scrum_master_dashboard',
      title: 'ScrumMasterDashboardScreen',
      child: Column(
        children: const [
          const ScrumMasterDashboardHeaderSection(),
          const ScrumMasterDashboardSummaryCardsSection(),
          const ScrumMasterDashboardChartOverviewSection(),
          const ScrumMasterDashboardRecentActivitySection(),
          const ScrumMasterDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
