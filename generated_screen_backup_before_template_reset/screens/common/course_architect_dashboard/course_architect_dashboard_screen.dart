import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/course_architect_dashboard_header_section.dart';
import 'sections/course_architect_dashboard_summary_cards_section.dart';
import 'sections/course_architect_dashboard_chart_overview_section.dart';
import 'sections/course_architect_dashboard_recent_activity_section.dart';
import 'sections/course_architect_dashboard_quick_actions_section.dart';

class CourseArchitectDashboardScreen extends StatelessWidget {
  const CourseArchitectDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'course_architect_dashboard',
      title: 'CourseArchitectDashboardScreen',
      child: Column(
        children: const [
          const CourseArchitectDashboardHeaderSection(),
          const CourseArchitectDashboardSummaryCardsSection(),
          const CourseArchitectDashboardChartOverviewSection(),
          const CourseArchitectDashboardRecentActivitySection(),
          const CourseArchitectDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
