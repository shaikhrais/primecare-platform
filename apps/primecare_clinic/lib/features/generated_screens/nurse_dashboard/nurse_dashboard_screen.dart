import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/nurse_dashboard_header_section.dart';
import 'sections/nurse_dashboard_summary_cards_section.dart';
import 'sections/nurse_dashboard_chart_overview_section.dart';
import 'sections/nurse_dashboard_recent_activity_section.dart';
import 'sections/nurse_dashboard_quick_actions_section.dart';

class NurseDashboardScreen extends StatelessWidget {
  const NurseDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'nurse_dashboard',
      title: 'Nurse Dashboard',
      child: Column(
        children: const [
          const NurseDashboardHeaderSection(),
          const NurseDashboardSummaryCardsSection(),
          const NurseDashboardChartOverviewSection(),
          const NurseDashboardRecentActivitySection(),
          const NurseDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
