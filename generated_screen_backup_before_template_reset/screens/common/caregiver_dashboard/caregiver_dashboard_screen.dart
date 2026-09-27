import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/caregiver_dashboard_header_section.dart';
import 'sections/caregiver_dashboard_summary_cards_section.dart';
import 'sections/caregiver_dashboard_chart_overview_section.dart';
import 'sections/caregiver_dashboard_recent_activity_section.dart';
import 'sections/caregiver_dashboard_quick_actions_section.dart';

class CaregiverDashboardScreen extends StatelessWidget {
  const CaregiverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'caregiver_dashboard',
      title: 'CaregiverDashboardScreen',
      child: Column(
        children: const [
          const CaregiverDashboardHeaderSection(),
          const CaregiverDashboardSummaryCardsSection(),
          const CaregiverDashboardChartOverviewSection(),
          const CaregiverDashboardRecentActivitySection(),
          const CaregiverDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
