import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ciso_dashboard_header_section.dart';
import 'sections/ciso_dashboard_summary_cards_section.dart';
import 'sections/ciso_dashboard_chart_overview_section.dart';
import 'sections/ciso_dashboard_recent_activity_section.dart';
import 'sections/ciso_dashboard_quick_actions_section.dart';

class CisoDashboardScreen extends StatelessWidget {
  const CisoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ciso_dashboard',
      title: 'CisoDashboardScreen',
      child: Column(
        children: const [
          const CisoDashboardHeaderSection(),
          const CisoDashboardSummaryCardsSection(),
          const CisoDashboardChartOverviewSection(),
          const CisoDashboardRecentActivitySection(),
          const CisoDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
