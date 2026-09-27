import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/premium_concierge_dashboard_header_section.dart';
import 'sections/premium_concierge_dashboard_summary_cards_section.dart';
import 'sections/premium_concierge_dashboard_chart_overview_section.dart';
import 'sections/premium_concierge_dashboard_recent_activity_section.dart';
import 'sections/premium_concierge_dashboard_quick_actions_section.dart';

class PremiumConciergeDashboardScreen extends StatelessWidget {
  const PremiumConciergeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'premium_concierge_dashboard',
      title: 'PremiumConciergeDashboardScreen',
      child: Column(
        children: const [
          const PremiumConciergeDashboardHeaderSection(),
          const PremiumConciergeDashboardSummaryCardsSection(),
          const PremiumConciergeDashboardChartOverviewSection(),
          const PremiumConciergeDashboardRecentActivitySection(),
          const PremiumConciergeDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
