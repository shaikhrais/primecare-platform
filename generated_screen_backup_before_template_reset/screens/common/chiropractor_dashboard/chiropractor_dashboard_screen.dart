import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_dashboard_header_section.dart';
import 'sections/chiropractor_dashboard_summary_cards_section.dart';
import 'sections/chiropractor_dashboard_chart_overview_section.dart';
import 'sections/chiropractor_dashboard_recent_activity_section.dart';
import 'sections/chiropractor_dashboard_quick_actions_section.dart';

class ChiropractorDashboardScreen extends StatelessWidget {
  const ChiropractorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_dashboard',
      title: 'ChiropractorDashboardScreen',
      child: Column(
        children: const [
          const ChiropractorDashboardHeaderSection(),
          const ChiropractorDashboardSummaryCardsSection(),
          const ChiropractorDashboardChartOverviewSection(),
          const ChiropractorDashboardRecentActivitySection(),
          const ChiropractorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
