import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_dashboard_header_section.dart';
import 'sections/ceo_dashboard_summary_cards_section.dart';
import 'sections/ceo_dashboard_chart_overview_section.dart';
import 'sections/ceo_dashboard_recent_activity_section.dart';
import 'sections/ceo_dashboard_quick_actions_section.dart';

class CeoDashboardScreen extends StatelessWidget {
  const CeoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_dashboard',
      title: 'Ceo Dashboard',
      child: Column(
        children: const [
          const CeoDashboardHeaderSection(),
          const CeoDashboardSummaryCardsSection(),
          const CeoDashboardChartOverviewSection(),
          const CeoDashboardRecentActivitySection(),
          const CeoDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
