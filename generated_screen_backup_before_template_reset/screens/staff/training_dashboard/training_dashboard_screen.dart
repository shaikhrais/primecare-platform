import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_dashboard_header_section.dart';
import 'sections/training_dashboard_summary_cards_section.dart';
import 'sections/training_dashboard_chart_overview_section.dart';
import 'sections/training_dashboard_recent_activity_section.dart';
import 'sections/training_dashboard_quick_actions_section.dart';

class TrainingDashboardScreen extends StatelessWidget {
  const TrainingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_dashboard',
      title: 'TrainingDashboardScreen',
      child: Column(
        children: const [
          const TrainingDashboardHeaderSection(),
          const TrainingDashboardSummaryCardsSection(),
          const TrainingDashboardChartOverviewSection(),
          const TrainingDashboardRecentActivitySection(),
          const TrainingDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
