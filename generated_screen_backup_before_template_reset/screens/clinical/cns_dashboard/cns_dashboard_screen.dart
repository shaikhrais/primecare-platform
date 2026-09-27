import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cns_dashboard_header_section.dart';
import 'sections/cns_dashboard_summary_cards_section.dart';
import 'sections/cns_dashboard_chart_overview_section.dart';
import 'sections/cns_dashboard_recent_activity_section.dart';
import 'sections/cns_dashboard_quick_actions_section.dart';

class CnsDashboardScreen extends StatelessWidget {
  const CnsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cns_dashboard',
      title: 'CnsDashboardScreen',
      child: Column(
        children: const [
          const CnsDashboardHeaderSection(),
          const CnsDashboardSummaryCardsSection(),
          const CnsDashboardChartOverviewSection(),
          const CnsDashboardRecentActivitySection(),
          const CnsDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
