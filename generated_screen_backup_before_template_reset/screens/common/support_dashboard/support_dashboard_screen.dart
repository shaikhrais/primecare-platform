import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/support_dashboard_header_section.dart';
import 'sections/support_dashboard_summary_cards_section.dart';
import 'sections/support_dashboard_chart_overview_section.dart';
import 'sections/support_dashboard_recent_activity_section.dart';
import 'sections/support_dashboard_quick_actions_section.dart';

class SupportDashboardScreen extends StatelessWidget {
  const SupportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'support_dashboard',
      title: 'SupportDashboardScreen',
      child: Column(
        children: const [
          const SupportDashboardHeaderSection(),
          const SupportDashboardSummaryCardsSection(),
          const SupportDashboardChartOverviewSection(),
          const SupportDashboardRecentActivitySection(),
          const SupportDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
