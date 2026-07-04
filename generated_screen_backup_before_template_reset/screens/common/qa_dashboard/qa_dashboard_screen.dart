import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/qa_dashboard_header_section.dart';
import 'sections/qa_dashboard_summary_cards_section.dart';
import 'sections/qa_dashboard_chart_overview_section.dart';
import 'sections/qa_dashboard_recent_activity_section.dart';
import 'sections/qa_dashboard_quick_actions_section.dart';

class QaDashboardScreen extends StatelessWidget {
  const QaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'qa_dashboard',
      title: 'QaDashboardScreen',
      child: Column(
        children: const [
          const QaDashboardHeaderSection(),
          const QaDashboardSummaryCardsSection(),
          const QaDashboardChartOverviewSection(),
          const QaDashboardRecentActivitySection(),
          const QaDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
