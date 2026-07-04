import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_dashboard_header_section.dart';
import 'sections/physiotherapist_dashboard_summary_cards_section.dart';
import 'sections/physiotherapist_dashboard_chart_overview_section.dart';
import 'sections/physiotherapist_dashboard_recent_activity_section.dart';
import 'sections/physiotherapist_dashboard_quick_actions_section.dart';

class PhysiotherapistDashboardScreen extends StatelessWidget {
  const PhysiotherapistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_dashboard',
      title: 'PhysiotherapistDashboardScreen',
      child: Column(
        children: const [
          const PhysiotherapistDashboardHeaderSection(),
          const PhysiotherapistDashboardSummaryCardsSection(),
          const PhysiotherapistDashboardChartOverviewSection(),
          const PhysiotherapistDashboardRecentActivitySection(),
          const PhysiotherapistDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
