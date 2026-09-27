import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_manager_usa_dashboard_header_section.dart';
import 'sections/regional_manager_usa_dashboard_summary_cards_section.dart';
import 'sections/regional_manager_usa_dashboard_chart_overview_section.dart';
import 'sections/regional_manager_usa_dashboard_recent_activity_section.dart';
import 'sections/regional_manager_usa_dashboard_quick_actions_section.dart';

class RegionalManagerUsaDashboardScreen extends StatelessWidget {
  const RegionalManagerUsaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_manager_usa_dashboard',
      title: 'RegionalManagerUsaDashboardScreen',
      child: Column(
        children: const [
          const RegionalManagerUsaDashboardHeaderSection(),
          const RegionalManagerUsaDashboardSummaryCardsSection(),
          const RegionalManagerUsaDashboardChartOverviewSection(),
          const RegionalManagerUsaDashboardRecentActivitySection(),
          const RegionalManagerUsaDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
