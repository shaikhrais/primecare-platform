import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_dashboard_header_section.dart';
import 'sections/quality_assurance_dashboard_summary_cards_section.dart';
import 'sections/quality_assurance_dashboard_chart_overview_section.dart';
import 'sections/quality_assurance_dashboard_recent_activity_section.dart';
import 'sections/quality_assurance_dashboard_quick_actions_section.dart';

class QualityAssuranceDashboardScreen extends StatelessWidget {
  const QualityAssuranceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_dashboard',
      title: 'QualityAssuranceDashboardScreen',
      child: Column(
        children: const [
          const QualityAssuranceDashboardHeaderSection(),
          const QualityAssuranceDashboardSummaryCardsSection(),
          const QualityAssuranceDashboardChartOverviewSection(),
          const QualityAssuranceDashboardRecentActivitySection(),
          const QualityAssuranceDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
