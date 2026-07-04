import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/finance_director_dashboard_header_section.dart';
import 'sections/finance_director_dashboard_summary_cards_section.dart';
import 'sections/finance_director_dashboard_chart_overview_section.dart';
import 'sections/finance_director_dashboard_recent_activity_section.dart';
import 'sections/finance_director_dashboard_quick_actions_section.dart';

class FinanceDirectorDashboardScreen extends StatelessWidget {
  const FinanceDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'finance_director_dashboard',
      title: 'FinanceDirectorDashboardScreen',
      child: Column(
        children: const [
          const FinanceDirectorDashboardHeaderSection(),
          const FinanceDirectorDashboardSummaryCardsSection(),
          const FinanceDirectorDashboardChartOverviewSection(),
          const FinanceDirectorDashboardRecentActivitySection(),
          const FinanceDirectorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
