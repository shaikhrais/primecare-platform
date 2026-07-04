import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/vip_manager_dashboard_header_section.dart';
import 'sections/vip_manager_dashboard_summary_cards_section.dart';
import 'sections/vip_manager_dashboard_chart_overview_section.dart';
import 'sections/vip_manager_dashboard_recent_activity_section.dart';
import 'sections/vip_manager_dashboard_quick_actions_section.dart';

class VipManagerDashboardScreen extends StatelessWidget {
  const VipManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'vip_manager_dashboard',
      title: 'VipManagerDashboardScreen',
      child: Column(
        children: const [
          const VipManagerDashboardHeaderSection(),
          const VipManagerDashboardSummaryCardsSection(),
          const VipManagerDashboardChartOverviewSection(),
          const VipManagerDashboardRecentActivitySection(),
          const VipManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
