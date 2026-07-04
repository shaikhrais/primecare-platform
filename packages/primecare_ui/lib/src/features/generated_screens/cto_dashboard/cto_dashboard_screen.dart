import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_dashboard_header_section.dart';
import 'sections/cto_dashboard_summary_cards_section.dart';
import 'sections/cto_dashboard_chart_overview_section.dart';
import 'sections/cto_dashboard_recent_activity_section.dart';
import 'sections/cto_dashboard_quick_actions_section.dart';

class CtoDashboardScreen extends StatelessWidget {
  const CtoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_dashboard',
      title: 'CtoDashboardScreen',
      child: Column(
        children: const [
          const CtoDashboardHeaderSection(),
          const CtoDashboardSummaryCardsSection(),
          const CtoDashboardChartOverviewSection(),
          const CtoDashboardRecentActivitySection(),
          const CtoDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
