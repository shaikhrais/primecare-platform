import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/owner_dashboard_header_section.dart';
import 'sections/owner_dashboard_summary_cards_section.dart';
import 'sections/owner_dashboard_chart_overview_section.dart';
import 'sections/owner_dashboard_recent_activity_section.dart';
import 'sections/owner_dashboard_quick_actions_section.dart';

class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'owner_dashboard',
      title: 'OwnerDashboardScreen',
      child: Column(
        children: const [
          const OwnerDashboardHeaderSection(),
          const OwnerDashboardSummaryCardsSection(),
          const OwnerDashboardChartOverviewSection(),
          const OwnerDashboardRecentActivitySection(),
          const OwnerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
