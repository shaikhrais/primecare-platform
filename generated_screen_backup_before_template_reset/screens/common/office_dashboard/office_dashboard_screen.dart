import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/office_dashboard_header_section.dart';
import 'sections/office_dashboard_summary_cards_section.dart';
import 'sections/office_dashboard_chart_overview_section.dart';
import 'sections/office_dashboard_recent_activity_section.dart';
import 'sections/office_dashboard_quick_actions_section.dart';

class OfficeDashboardScreen extends StatelessWidget {
  const OfficeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'office_dashboard',
      title: 'OfficeDashboardScreen',
      child: Column(
        children: const [
          const OfficeDashboardHeaderSection(),
          const OfficeDashboardSummaryCardsSection(),
          const OfficeDashboardChartOverviewSection(),
          const OfficeDashboardRecentActivitySection(),
          const OfficeDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
