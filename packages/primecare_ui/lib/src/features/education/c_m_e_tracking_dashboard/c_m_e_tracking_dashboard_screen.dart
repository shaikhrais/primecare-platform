import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/c_m_e_tracking_dashboard_header_section.dart';
import 'sections/c_m_e_tracking_dashboard_summary_cards_section.dart';
import 'sections/c_m_e_tracking_dashboard_chart_overview_section.dart';
import 'sections/c_m_e_tracking_dashboard_recent_activity_section.dart';
import 'sections/c_m_e_tracking_dashboard_quick_actions_section.dart';

class CMETrackingDashboardScreen extends StatelessWidget {
  const CMETrackingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'c_m_e_tracking_dashboard',
      title: 'C M E Tracking Dashboard',
      child: Column(
        children: const [
          const CMETrackingDashboardHeaderSection(),
          const CMETrackingDashboardSummaryCardsSection(),
          const CMETrackingDashboardChartOverviewSection(),
          const CMETrackingDashboardRecentActivitySection(),
          const CMETrackingDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
