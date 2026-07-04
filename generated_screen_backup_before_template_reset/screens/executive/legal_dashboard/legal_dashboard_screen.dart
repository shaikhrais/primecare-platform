import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/legal_dashboard_header_section.dart';
import 'sections/legal_dashboard_summary_cards_section.dart';
import 'sections/legal_dashboard_chart_overview_section.dart';
import 'sections/legal_dashboard_recent_activity_section.dart';
import 'sections/legal_dashboard_quick_actions_section.dart';

class LegalDashboardScreen extends StatelessWidget {
  const LegalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'legal_dashboard',
      title: 'LegalDashboardScreen',
      child: Column(
        children: const [
          const LegalDashboardHeaderSection(),
          const LegalDashboardSummaryCardsSection(),
          const LegalDashboardChartOverviewSection(),
          const LegalDashboardRecentActivitySection(),
          const LegalDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
