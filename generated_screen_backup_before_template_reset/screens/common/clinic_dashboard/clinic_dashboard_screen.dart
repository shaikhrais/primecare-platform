import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinic_dashboard_header_section.dart';
import 'sections/clinic_dashboard_summary_cards_section.dart';
import 'sections/clinic_dashboard_chart_overview_section.dart';
import 'sections/clinic_dashboard_recent_activity_section.dart';
import 'sections/clinic_dashboard_quick_actions_section.dart';

class ClinicDashboardScreen extends StatelessWidget {
  const ClinicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinic_dashboard',
      title: 'ClinicDashboardScreen',
      child: Column(
        children: const [
          const ClinicDashboardHeaderSection(),
          const ClinicDashboardSummaryCardsSection(),
          const ClinicDashboardChartOverviewSection(),
          const ClinicDashboardRecentActivitySection(),
          const ClinicDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
