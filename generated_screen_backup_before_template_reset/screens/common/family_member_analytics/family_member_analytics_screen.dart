import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_analytics_header_section.dart';
import 'sections/family_member_analytics_filter_bar_section.dart';
import 'sections/family_member_analytics_metrics_summary_section.dart';
import 'sections/family_member_analytics_chart_area_section.dart';
import 'sections/family_member_analytics_export_actions_section.dart';

class FamilyMemberAnalyticsScreen extends StatelessWidget {
  const FamilyMemberAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_analytics',
      title: 'FamilyMemberAnalyticsScreen',
      child: Column(
        children: const [
          const FamilyMemberAnalyticsHeaderSection(),
          const FamilyMemberAnalyticsFilterBarSection(),
          const FamilyMemberAnalyticsMetricsSummarySection(),
          const FamilyMemberAnalyticsChartAreaSection(),
          const FamilyMemberAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
