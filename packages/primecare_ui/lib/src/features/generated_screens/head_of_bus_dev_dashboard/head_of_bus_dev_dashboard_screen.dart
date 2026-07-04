import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_bus_dev_dashboard_header_section.dart';
import 'sections/head_of_bus_dev_dashboard_summary_cards_section.dart';
import 'sections/head_of_bus_dev_dashboard_chart_overview_section.dart';
import 'sections/head_of_bus_dev_dashboard_recent_activity_section.dart';
import 'sections/head_of_bus_dev_dashboard_quick_actions_section.dart';

class HeadOfBusDevDashboardScreen extends StatelessWidget {
  const HeadOfBusDevDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_bus_dev_dashboard',
      title: 'HeadOfBusDevDashboardScreen',
      child: Column(
        children: const [
          const HeadOfBusDevDashboardHeaderSection(),
          const HeadOfBusDevDashboardSummaryCardsSection(),
          const HeadOfBusDevDashboardChartOverviewSection(),
          const HeadOfBusDevDashboardRecentActivitySection(),
          const HeadOfBusDevDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
