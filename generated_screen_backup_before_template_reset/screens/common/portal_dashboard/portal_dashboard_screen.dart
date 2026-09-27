import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/portal_dashboard_header_section.dart';
import 'sections/portal_dashboard_summary_cards_section.dart';
import 'sections/portal_dashboard_chart_overview_section.dart';
import 'sections/portal_dashboard_recent_activity_section.dart';
import 'sections/portal_dashboard_quick_actions_section.dart';

class PortalDashboardScreen extends StatelessWidget {
  const PortalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'portal_dashboard',
      title: 'PortalDashboardScreen',
      child: Column(
        children: const [
          const PortalDashboardHeaderSection(),
          const PortalDashboardSummaryCardsSection(),
          const PortalDashboardChartOverviewSection(),
          const PortalDashboardRecentActivitySection(),
          const PortalDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
