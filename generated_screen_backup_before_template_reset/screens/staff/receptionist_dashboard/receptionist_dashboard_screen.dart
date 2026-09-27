import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/receptionist_dashboard_header_section.dart';
import 'sections/receptionist_dashboard_summary_cards_section.dart';
import 'sections/receptionist_dashboard_chart_overview_section.dart';
import 'sections/receptionist_dashboard_recent_activity_section.dart';
import 'sections/receptionist_dashboard_quick_actions_section.dart';

class ReceptionistDashboardScreen extends StatelessWidget {
  const ReceptionistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'receptionist_dashboard',
      title: 'ReceptionistDashboardScreen',
      child: Column(
        children: const [
          const ReceptionistDashboardHeaderSection(),
          const ReceptionistDashboardSummaryCardsSection(),
          const ReceptionistDashboardChartOverviewSection(),
          const ReceptionistDashboardRecentActivitySection(),
          const ReceptionistDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
