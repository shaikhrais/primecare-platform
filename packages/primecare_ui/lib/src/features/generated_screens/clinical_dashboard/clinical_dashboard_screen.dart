import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_dashboard_header_section.dart';
import 'sections/clinical_dashboard_summary_cards_section.dart';
import 'sections/clinical_dashboard_chart_overview_section.dart';
import 'sections/clinical_dashboard_recent_activity_section.dart';
import 'sections/clinical_dashboard_quick_actions_section.dart';

class ClinicalDashboardScreen extends StatelessWidget {
  const ClinicalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_dashboard',
      title: 'ClinicalDashboardScreen',
      child: Column(
        children: const [
          const ClinicalDashboardHeaderSection(),
          const ClinicalDashboardSummaryCardsSection(),
          const ClinicalDashboardChartOverviewSection(),
          const ClinicalDashboardRecentActivitySection(),
          const ClinicalDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
