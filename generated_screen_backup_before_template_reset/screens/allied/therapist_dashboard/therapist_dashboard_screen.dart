import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/therapist_dashboard_header_section.dart';
import 'sections/therapist_dashboard_summary_cards_section.dart';
import 'sections/therapist_dashboard_chart_overview_section.dart';
import 'sections/therapist_dashboard_recent_activity_section.dart';
import 'sections/therapist_dashboard_quick_actions_section.dart';

class TherapistDashboardScreen extends StatelessWidget {
  const TherapistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'therapist_dashboard',
      title: 'TherapistDashboardScreen',
      child: Column(
        children: const [
          const TherapistDashboardHeaderSection(),
          const TherapistDashboardSummaryCardsSection(),
          const TherapistDashboardChartOverviewSection(),
          const TherapistDashboardRecentActivitySection(),
          const TherapistDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
