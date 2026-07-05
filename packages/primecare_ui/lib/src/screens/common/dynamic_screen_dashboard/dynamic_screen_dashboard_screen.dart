import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/dynamic_screen_dashboard_header_section.dart';
import 'sections/dynamic_screen_dashboard_summary_cards_section.dart';
import 'sections/dynamic_screen_dashboard_chart_overview_section.dart';
import 'sections/dynamic_screen_dashboard_recent_activity_section.dart';
import 'sections/dynamic_screen_dashboard_quick_actions_section.dart';

class DynamicScreenDashboardScreen extends StatelessWidget {
  const DynamicScreenDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'dynamic_screen_dashboard',
      title: 'DynamicScreenDashboardScreen',
      child: Column(
        children: const [
          const DynamicScreenDashboardHeaderSection(),
          const DynamicScreenDashboardSummaryCardsSection(),
          const DynamicScreenDashboardChartOverviewSection(),
          const DynamicScreenDashboardRecentActivitySection(),
          const DynamicScreenDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}

typedef DynamicDashboardScreen = DynamicScreenDashboardScreen;
