import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_dashboard_header_section.dart';
import 'sections/clinical_director_dashboard_summary_cards_section.dart';
import 'sections/clinical_director_dashboard_chart_overview_section.dart';
import 'sections/clinical_director_dashboard_recent_activity_section.dart';
import 'sections/clinical_director_dashboard_quick_actions_section.dart';

class ClinicalDirectorDashboardScreen extends StatelessWidget {
  const ClinicalDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_dashboard',
      title: 'Clinical Director Dashboard',
      child: Column(
        children: const [
          const ClinicalDirectorDashboardHeaderSection(),
          const ClinicalDirectorDashboardSummaryCardsSection(),
          const ClinicalDirectorDashboardChartOverviewSection(),
          const ClinicalDirectorDashboardRecentActivitySection(),
          const ClinicalDirectorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
