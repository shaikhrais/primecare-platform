import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_dashboard_header_section.dart';
import 'sections/regional_bdm_dashboard_summary_cards_section.dart';
import 'sections/regional_bdm_dashboard_chart_overview_section.dart';
import 'sections/regional_bdm_dashboard_recent_activity_section.dart';
import 'sections/regional_bdm_dashboard_quick_actions_section.dart';

class RegionalBdmDashboardScreen extends StatelessWidget {
  const RegionalBdmDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_dashboard',
      title: 'RegionalBdmDashboardScreen',
      child: Column(
        children: const [
          const RegionalBdmDashboardHeaderSection(),
          const RegionalBdmDashboardSummaryCardsSection(),
          const RegionalBdmDashboardChartOverviewSection(),
          const RegionalBdmDashboardRecentActivitySection(),
          const RegionalBdmDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
