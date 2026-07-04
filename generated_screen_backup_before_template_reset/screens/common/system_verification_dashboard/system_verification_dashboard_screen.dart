import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_verification_dashboard_header_section.dart';
import 'sections/system_verification_dashboard_summary_cards_section.dart';
import 'sections/system_verification_dashboard_chart_overview_section.dart';
import 'sections/system_verification_dashboard_recent_activity_section.dart';
import 'sections/system_verification_dashboard_quick_actions_section.dart';

class SystemVerificationDashboardScreen extends StatelessWidget {
  const SystemVerificationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_verification_dashboard',
      title: 'SystemVerificationDashboardScreen',
      child: Column(
        children: const [
          const SystemVerificationDashboardHeaderSection(),
          const SystemVerificationDashboardSummaryCardsSection(),
          const SystemVerificationDashboardChartOverviewSection(),
          const SystemVerificationDashboardRecentActivitySection(),
          const SystemVerificationDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
