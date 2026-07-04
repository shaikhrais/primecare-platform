import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_dashboard_header_section.dart';
import 'sections/rpn_dashboard_summary_cards_section.dart';
import 'sections/rpn_dashboard_chart_overview_section.dart';
import 'sections/rpn_dashboard_recent_activity_section.dart';
import 'sections/rpn_dashboard_quick_actions_section.dart';

class RpnDashboardScreen extends StatelessWidget {
  const RpnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_dashboard',
      title: 'RpnDashboardScreen',
      child: Column(
        children: const [
          const RpnDashboardHeaderSection(),
          const RpnDashboardSummaryCardsSection(),
          const RpnDashboardChartOverviewSection(),
          const RpnDashboardRecentActivitySection(),
          const RpnDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
