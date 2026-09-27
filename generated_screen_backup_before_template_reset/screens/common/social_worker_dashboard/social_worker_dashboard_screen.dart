import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/social_worker_dashboard_header_section.dart';
import 'sections/social_worker_dashboard_summary_cards_section.dart';
import 'sections/social_worker_dashboard_chart_overview_section.dart';
import 'sections/social_worker_dashboard_recent_activity_section.dart';
import 'sections/social_worker_dashboard_quick_actions_section.dart';

class SocialWorkerDashboardScreen extends StatelessWidget {
  const SocialWorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'social_worker_dashboard',
      title: 'SocialWorkerDashboardScreen',
      child: Column(
        children: const [
          const SocialWorkerDashboardHeaderSection(),
          const SocialWorkerDashboardSummaryCardsSection(),
          const SocialWorkerDashboardChartOverviewSection(),
          const SocialWorkerDashboardRecentActivitySection(),
          const SocialWorkerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
