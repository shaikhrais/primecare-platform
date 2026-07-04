import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_hub_dashboard_header_section.dart';
import 'sections/training_hub_dashboard_summary_cards_section.dart';
import 'sections/training_hub_dashboard_chart_overview_section.dart';
import 'sections/training_hub_dashboard_recent_activity_section.dart';
import 'sections/training_hub_dashboard_quick_actions_section.dart';

class TrainingHubDashboardScreen extends StatelessWidget {
  const TrainingHubDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_hub_dashboard',
      title: 'TrainingHubDashboardScreen',
      child: Column(
        children: const [
          const TrainingHubDashboardHeaderSection(),
          const TrainingHubDashboardSummaryCardsSection(),
          const TrainingHubDashboardChartOverviewSection(),
          const TrainingHubDashboardRecentActivitySection(),
          const TrainingHubDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
