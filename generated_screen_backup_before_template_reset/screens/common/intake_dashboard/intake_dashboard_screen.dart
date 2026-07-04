import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_dashboard_header_section.dart';
import 'sections/intake_dashboard_summary_cards_section.dart';
import 'sections/intake_dashboard_chart_overview_section.dart';
import 'sections/intake_dashboard_recent_activity_section.dart';
import 'sections/intake_dashboard_quick_actions_section.dart';

class IntakeDashboardScreen extends StatelessWidget {
  const IntakeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_dashboard',
      title: 'IntakeDashboardScreen',
      child: Column(
        children: const [
          const IntakeDashboardHeaderSection(),
          const IntakeDashboardSummaryCardsSection(),
          const IntakeDashboardChartOverviewSection(),
          const IntakeDashboardRecentActivitySection(),
          const IntakeDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
