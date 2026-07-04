import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_dashboard_header_section.dart';
import 'sections/system_dashboard_summary_cards_section.dart';
import 'sections/system_dashboard_chart_overview_section.dart';
import 'sections/system_dashboard_recent_activity_section.dart';
import 'sections/system_dashboard_quick_actions_section.dart';

class SystemDashboardScreen extends StatelessWidget {
  const SystemDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_dashboard',
      title: 'SystemDashboardScreen',
      child: Column(
        children: const [
          const SystemDashboardHeaderSection(),
          const SystemDashboardSummaryCardsSection(),
          const SystemDashboardChartOverviewSection(),
          const SystemDashboardRecentActivitySection(),
          const SystemDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
