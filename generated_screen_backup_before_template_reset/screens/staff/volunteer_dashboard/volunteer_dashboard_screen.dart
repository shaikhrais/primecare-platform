import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/volunteer_dashboard_header_section.dart';
import 'sections/volunteer_dashboard_summary_cards_section.dart';
import 'sections/volunteer_dashboard_chart_overview_section.dart';
import 'sections/volunteer_dashboard_recent_activity_section.dart';
import 'sections/volunteer_dashboard_quick_actions_section.dart';

class VolunteerDashboardScreen extends StatelessWidget {
  const VolunteerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'volunteer_dashboard',
      title: 'VolunteerDashboardScreen',
      child: Column(
        children: const [
          const VolunteerDashboardHeaderSection(),
          const VolunteerDashboardSummaryCardsSection(),
          const VolunteerDashboardChartOverviewSection(),
          const VolunteerDashboardRecentActivitySection(),
          const VolunteerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
