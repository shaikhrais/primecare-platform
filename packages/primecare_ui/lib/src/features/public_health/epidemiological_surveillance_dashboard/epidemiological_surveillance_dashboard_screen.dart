import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/epidemiological_surveillance_dashboard_header_section.dart';
import 'sections/epidemiological_surveillance_dashboard_summary_cards_section.dart';
import 'sections/epidemiological_surveillance_dashboard_chart_overview_section.dart';
import 'sections/epidemiological_surveillance_dashboard_recent_activity_section.dart';
import 'sections/epidemiological_surveillance_dashboard_quick_actions_section.dart';

class EpidemiologicalSurveillanceDashboardScreen extends StatelessWidget {
  const EpidemiologicalSurveillanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'epidemiological_surveillance_dashboard',
      title: 'Epidemiological Surveillance Dashboard',
      child: Column(
        children: const [
          const EpidemiologicalSurveillanceDashboardHeaderSection(),
          const EpidemiologicalSurveillanceDashboardSummaryCardsSection(),
          const EpidemiologicalSurveillanceDashboardChartOverviewSection(),
          const EpidemiologicalSurveillanceDashboardRecentActivitySection(),
          const EpidemiologicalSurveillanceDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
