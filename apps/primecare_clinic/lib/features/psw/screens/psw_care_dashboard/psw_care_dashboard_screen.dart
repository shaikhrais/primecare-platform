import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_care_dashboard_header_section.dart';
import 'sections/psw_care_dashboard_summary_cards_section.dart';
import 'sections/psw_care_dashboard_chart_overview_section.dart';
import 'sections/psw_care_dashboard_recent_activity_section.dart';
import 'sections/psw_care_dashboard_quick_actions_section.dart';

class PswCareDashboardScreen extends StatelessWidget {
  const PswCareDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_care_dashboard',
      title: 'Psw Care Dashboard',
      child: Column(
        children: const [
          const PswCareDashboardHeaderSection(),
          const PswCareDashboardSummaryCardsSection(),
          const PswCareDashboardChartOverviewSection(),
          const PswCareDashboardRecentActivitySection(),
          const PswCareDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
