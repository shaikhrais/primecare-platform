import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/financial_dashboard_header_section.dart';
import 'sections/financial_dashboard_summary_cards_section.dart';
import 'sections/financial_dashboard_chart_overview_section.dart';
import 'sections/financial_dashboard_recent_activity_section.dart';
import 'sections/financial_dashboard_quick_actions_section.dart';

class FinancialDashboardScreen extends StatelessWidget {
  const FinancialDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'financial_dashboard',
      title: 'FinancialDashboardScreen',
      child: Column(
        children: const [
          const FinancialDashboardHeaderSection(),
          const FinancialDashboardSummaryCardsSection(),
          const FinancialDashboardChartOverviewSection(),
          const FinancialDashboardRecentActivitySection(),
          const FinancialDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
