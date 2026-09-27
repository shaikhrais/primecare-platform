import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_dashboard_header_section.dart';
import 'sections/patient_dashboard_summary_cards_section.dart';
import 'sections/patient_dashboard_chart_overview_section.dart';
import 'sections/patient_dashboard_recent_activity_section.dart';
import 'sections/patient_dashboard_quick_actions_section.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_dashboard',
      title: 'PatientDashboardScreen',
      child: Column(
        children: const [
          const PatientDashboardHeaderSection(),
          const PatientDashboardSummaryCardsSection(),
          const PatientDashboardChartOverviewSection(),
          const PatientDashboardRecentActivitySection(),
          const PatientDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
