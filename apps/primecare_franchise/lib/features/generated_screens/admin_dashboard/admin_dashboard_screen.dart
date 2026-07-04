import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_dashboard_header_section.dart';
import 'sections/admin_dashboard_summary_cards_section.dart';
import 'sections/admin_dashboard_chart_overview_section.dart';
import 'sections/admin_dashboard_recent_activity_section.dart';
import 'sections/admin_dashboard_quick_actions_section.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_dashboard',
      title: 'Admin Dashboard',
      child: Column(
        children: const [
          const AdminDashboardHeaderSection(),
          const AdminDashboardSummaryCardsSection(),
          const AdminDashboardChartOverviewSection(),
          const AdminDashboardRecentActivitySection(),
          const AdminDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
