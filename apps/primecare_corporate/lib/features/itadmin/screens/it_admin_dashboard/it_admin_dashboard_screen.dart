import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/it_admin_dashboard_header_section.dart';
import 'sections/it_admin_dashboard_summary_cards_section.dart';
import 'sections/it_admin_dashboard_chart_overview_section.dart';
import 'sections/it_admin_dashboard_recent_activity_section.dart';
import 'sections/it_admin_dashboard_quick_actions_section.dart';

class ItAdminDashboardScreen extends StatelessWidget {
  const ItAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'it_admin_dashboard',
      title: 'It Admin Dashboard',
      child: Column(
        children: const [
          const ItAdminDashboardHeaderSection(),
          const ItAdminDashboardSummaryCardsSection(),
          const ItAdminDashboardChartOverviewSection(),
          const ItAdminDashboardRecentActivitySection(),
          const ItAdminDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
