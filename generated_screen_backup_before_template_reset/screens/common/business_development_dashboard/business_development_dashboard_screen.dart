import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/business_development_dashboard_header_section.dart';
import 'sections/business_development_dashboard_summary_cards_section.dart';
import 'sections/business_development_dashboard_chart_overview_section.dart';
import 'sections/business_development_dashboard_recent_activity_section.dart';
import 'sections/business_development_dashboard_quick_actions_section.dart';

class BusinessDevelopmentDashboardScreen extends StatelessWidget {
  const BusinessDevelopmentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'business_development_dashboard',
      title: 'BusinessDevelopmentDashboardScreen',
      child: Column(
        children: const [
          const BusinessDevelopmentDashboardHeaderSection(),
          const BusinessDevelopmentDashboardSummaryCardsSection(),
          const BusinessDevelopmentDashboardChartOverviewSection(),
          const BusinessDevelopmentDashboardRecentActivitySection(),
          const BusinessDevelopmentDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
