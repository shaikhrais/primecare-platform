import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/shareholder_dashboard_header_section.dart';
import 'sections/shareholder_dashboard_summary_cards_section.dart';
import 'sections/shareholder_dashboard_chart_overview_section.dart';
import 'sections/shareholder_dashboard_recent_activity_section.dart';
import 'sections/shareholder_dashboard_quick_actions_section.dart';

class ShareholderDashboardScreen extends StatelessWidget {
  const ShareholderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'shareholder_dashboard',
      title: 'ShareholderDashboardScreen',
      child: Column(
        children: const [
          const ShareholderDashboardHeaderSection(),
          const ShareholderDashboardSummaryCardsSection(),
          const ShareholderDashboardChartOverviewSection(),
          const ShareholderDashboardRecentActivitySection(),
          const ShareholderDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
