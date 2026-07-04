import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_dashboard_header_section.dart';
import 'sections/coo_dashboard_summary_cards_section.dart';
import 'sections/coo_dashboard_chart_overview_section.dart';
import 'sections/coo_dashboard_recent_activity_section.dart';
import 'sections/coo_dashboard_quick_actions_section.dart';

class CooDashboardScreen extends StatelessWidget {
  const CooDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_dashboard',
      title: 'CooDashboardScreen',
      child: Column(
        children: const [
          const CooDashboardHeaderSection(),
          const CooDashboardSummaryCardsSection(),
          const CooDashboardChartOverviewSection(),
          const CooDashboardRecentActivitySection(),
          const CooDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
