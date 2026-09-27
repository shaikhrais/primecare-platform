import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_dashboard_header_section.dart';
import 'sections/client_dashboard_summary_cards_section.dart';
import 'sections/client_dashboard_chart_overview_section.dart';
import 'sections/client_dashboard_recent_activity_section.dart';
import 'sections/client_dashboard_quick_actions_section.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_dashboard',
      title: 'Client Dashboard',
      child: Column(
        children: const [
          const ClientDashboardHeaderSection(),
          const ClientDashboardSummaryCardsSection(),
          const ClientDashboardChartOverviewSection(),
          const ClientDashboardRecentActivitySection(),
          const ClientDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
