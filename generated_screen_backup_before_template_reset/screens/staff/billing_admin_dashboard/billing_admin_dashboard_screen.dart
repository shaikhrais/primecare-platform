import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_admin_dashboard_header_section.dart';
import 'sections/billing_admin_dashboard_summary_cards_section.dart';
import 'sections/billing_admin_dashboard_chart_overview_section.dart';
import 'sections/billing_admin_dashboard_recent_activity_section.dart';
import 'sections/billing_admin_dashboard_quick_actions_section.dart';

class BillingAdminDashboardScreen extends StatelessWidget {
  const BillingAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_admin_dashboard',
      title: 'BillingAdminDashboardScreen',
      child: Column(
        children: const [
          const BillingAdminDashboardHeaderSection(),
          const BillingAdminDashboardSummaryCardsSection(),
          const BillingAdminDashboardChartOverviewSection(),
          const BillingAdminDashboardRecentActivitySection(),
          const BillingAdminDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
