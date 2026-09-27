import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_dashboard_header_section.dart';
import 'sections/customer_support_dashboard_summary_cards_section.dart';
import 'sections/customer_support_dashboard_chart_overview_section.dart';
import 'sections/customer_support_dashboard_recent_activity_section.dart';
import 'sections/customer_support_dashboard_quick_actions_section.dart';

class CustomerSupportDashboardScreen extends StatelessWidget {
  const CustomerSupportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_dashboard',
      title: 'CustomerSupportDashboardScreen',
      child: Column(
        children: const [
          const CustomerSupportDashboardHeaderSection(),
          const CustomerSupportDashboardSummaryCardsSection(),
          const CustomerSupportDashboardChartOverviewSection(),
          const CustomerSupportDashboardRecentActivitySection(),
          const CustomerSupportDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
