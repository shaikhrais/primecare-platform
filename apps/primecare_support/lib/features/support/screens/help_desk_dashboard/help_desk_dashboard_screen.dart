import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/help_desk_dashboard_header_section.dart';
import 'sections/help_desk_dashboard_summary_cards_section.dart';
import 'sections/help_desk_dashboard_chart_overview_section.dart';
import 'sections/help_desk_dashboard_recent_activity_section.dart';
import 'sections/help_desk_dashboard_quick_actions_section.dart';

class HelpDeskDashboardScreen extends StatelessWidget {
  const HelpDeskDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'help_desk_dashboard',
      title: 'Help Desk Dashboard',
      child: Column(
        children: const [
          const HelpDeskDashboardHeaderSection(),
          const HelpDeskDashboardSummaryCardsSection(),
          const HelpDeskDashboardChartOverviewSection(),
          const HelpDeskDashboardRecentActivitySection(),
          const HelpDeskDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
