import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/guest_dashboard_header_section.dart';
import 'sections/guest_dashboard_summary_cards_section.dart';
import 'sections/guest_dashboard_chart_overview_section.dart';
import 'sections/guest_dashboard_recent_activity_section.dart';
import 'sections/guest_dashboard_quick_actions_section.dart';

class GuestDashboardScreen extends StatelessWidget {
  const GuestDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'guest_dashboard',
      title: 'GuestDashboardScreen',
      child: Column(
        children: const [
          const GuestDashboardHeaderSection(),
          const GuestDashboardSummaryCardsSection(),
          const GuestDashboardChartOverviewSection(),
          const GuestDashboardRecentActivitySection(),
          const GuestDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
