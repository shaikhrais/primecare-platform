import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_dashboard_header_section.dart';
import 'sections/training_coordinator_dashboard_summary_cards_section.dart';
import 'sections/training_coordinator_dashboard_chart_overview_section.dart';
import 'sections/training_coordinator_dashboard_recent_activity_section.dart';
import 'sections/training_coordinator_dashboard_quick_actions_section.dart';

class TrainingCoordinatorDashboardScreen extends StatelessWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_dashboard',
      title: 'TrainingCoordinatorDashboardScreen',
      child: Column(
        children: const [
          const TrainingCoordinatorDashboardHeaderSection(),
          const TrainingCoordinatorDashboardSummaryCardsSection(),
          const TrainingCoordinatorDashboardChartOverviewSection(),
          const TrainingCoordinatorDashboardRecentActivitySection(),
          const TrainingCoordinatorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
