import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/pharmacy_dispensing_dashboard_header_section.dart';
import 'sections/pharmacy_dispensing_dashboard_summary_cards_section.dart';
import 'sections/pharmacy_dispensing_dashboard_chart_overview_section.dart';
import 'sections/pharmacy_dispensing_dashboard_recent_activity_section.dart';
import 'sections/pharmacy_dispensing_dashboard_quick_actions_section.dart';

class PharmacyDispensingDashboardScreen extends StatelessWidget {
  const PharmacyDispensingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'pharmacy_dispensing_dashboard',
      title: 'Pharmacy Dispensing Dashboard',
      child: Column(
        children: const [
          const PharmacyDispensingDashboardHeaderSection(),
          const PharmacyDispensingDashboardSummaryCardsSection(),
          const PharmacyDispensingDashboardChartOverviewSection(),
          const PharmacyDispensingDashboardRecentActivitySection(),
          const PharmacyDispensingDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
