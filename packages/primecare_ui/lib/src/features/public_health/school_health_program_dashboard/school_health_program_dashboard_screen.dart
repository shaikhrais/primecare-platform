import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/school_health_program_dashboard_header_section.dart';
import 'sections/school_health_program_dashboard_summary_cards_section.dart';
import 'sections/school_health_program_dashboard_chart_overview_section.dart';
import 'sections/school_health_program_dashboard_recent_activity_section.dart';
import 'sections/school_health_program_dashboard_quick_actions_section.dart';

class SchoolHealthProgramDashboardScreen extends StatelessWidget {
  const SchoolHealthProgramDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'school_health_program_dashboard',
      title: 'School Health Program Dashboard',
      child: Column(
        children: const [
          const SchoolHealthProgramDashboardHeaderSection(),
          const SchoolHealthProgramDashboardSummaryCardsSection(),
          const SchoolHealthProgramDashboardChartOverviewSection(),
          const SchoolHealthProgramDashboardRecentActivitySection(),
          const SchoolHealthProgramDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
