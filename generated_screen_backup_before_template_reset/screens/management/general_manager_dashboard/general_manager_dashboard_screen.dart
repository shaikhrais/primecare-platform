import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/general_manager_dashboard_header_section.dart';
import 'sections/general_manager_dashboard_summary_cards_section.dart';
import 'sections/general_manager_dashboard_chart_overview_section.dart';
import 'sections/general_manager_dashboard_recent_activity_section.dart';
import 'sections/general_manager_dashboard_quick_actions_section.dart';

class GeneralManagerDashboardScreen extends StatelessWidget {
  const GeneralManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'general_manager_dashboard',
      title: 'GeneralManagerDashboardScreen',
      child: Column(
        children: const [
          const GeneralManagerDashboardHeaderSection(),
          const GeneralManagerDashboardSummaryCardsSection(),
          const GeneralManagerDashboardChartOverviewSection(),
          const GeneralManagerDashboardRecentActivitySection(),
          const GeneralManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
