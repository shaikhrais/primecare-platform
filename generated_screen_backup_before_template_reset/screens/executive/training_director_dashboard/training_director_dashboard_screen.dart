import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_dashboard_header_section.dart';
import 'sections/training_director_dashboard_summary_cards_section.dart';
import 'sections/training_director_dashboard_chart_overview_section.dart';
import 'sections/training_director_dashboard_recent_activity_section.dart';
import 'sections/training_director_dashboard_quick_actions_section.dart';

class TrainingDirectorDashboardScreen extends StatelessWidget {
  const TrainingDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_dashboard',
      title: 'TrainingDirectorDashboardScreen',
      child: Column(
        children: const [
          const TrainingDirectorDashboardHeaderSection(),
          const TrainingDirectorDashboardSummaryCardsSection(),
          const TrainingDirectorDashboardChartOverviewSection(),
          const TrainingDirectorDashboardRecentActivitySection(),
          const TrainingDirectorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
