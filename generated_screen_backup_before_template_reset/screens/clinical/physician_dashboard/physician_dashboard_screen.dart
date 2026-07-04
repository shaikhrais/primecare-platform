import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physician_dashboard_header_section.dart';
import 'sections/physician_dashboard_summary_cards_section.dart';
import 'sections/physician_dashboard_chart_overview_section.dart';
import 'sections/physician_dashboard_recent_activity_section.dart';
import 'sections/physician_dashboard_quick_actions_section.dart';

class PhysicianDashboardScreen extends StatelessWidget {
  const PhysicianDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physician_dashboard',
      title: 'PhysicianDashboardScreen',
      child: Column(
        children: const [
          const PhysicianDashboardHeaderSection(),
          const PhysicianDashboardSummaryCardsSection(),
          const PhysicianDashboardChartOverviewSection(),
          const PhysicianDashboardRecentActivitySection(),
          const PhysicianDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
