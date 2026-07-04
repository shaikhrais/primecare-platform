import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/file_verification_dashboard_header_section.dart';
import 'sections/file_verification_dashboard_summary_cards_section.dart';
import 'sections/file_verification_dashboard_chart_overview_section.dart';
import 'sections/file_verification_dashboard_recent_activity_section.dart';
import 'sections/file_verification_dashboard_quick_actions_section.dart';

class FileVerificationDashboardScreen extends StatelessWidget {
  const FileVerificationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'file_verification_dashboard',
      title: 'FileVerificationDashboardScreen',
      child: Column(
        children: const [
          const FileVerificationDashboardHeaderSection(),
          const FileVerificationDashboardSummaryCardsSection(),
          const FileVerificationDashboardChartOverviewSection(),
          const FileVerificationDashboardRecentActivitySection(),
          const FileVerificationDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
