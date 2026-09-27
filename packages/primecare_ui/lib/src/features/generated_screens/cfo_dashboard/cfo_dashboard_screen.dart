import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_dashboard_header_section.dart';
import 'sections/cfo_dashboard_summary_cards_section.dart';
import 'sections/cfo_dashboard_chart_overview_section.dart';
import 'sections/cfo_dashboard_recent_activity_section.dart';
import 'sections/cfo_dashboard_quick_actions_section.dart';

class CfoDashboardScreen extends StatelessWidget {
  const CfoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_dashboard',
      title: 'CfoDashboardScreen',
      child: Column(
        children: const [
          const CfoDashboardHeaderSection(),
          const CfoDashboardSummaryCardsSection(),
          const CfoDashboardChartOverviewSection(),
          const CfoDashboardRecentActivitySection(),
          const CfoDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
