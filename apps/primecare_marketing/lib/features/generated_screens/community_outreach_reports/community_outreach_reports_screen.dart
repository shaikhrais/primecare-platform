import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_reports_header_section.dart';
import 'sections/community_outreach_reports_filter_bar_section.dart';
import 'sections/community_outreach_reports_metrics_summary_section.dart';
import 'sections/community_outreach_reports_chart_area_section.dart';
import 'sections/community_outreach_reports_export_actions_section.dart';

class CommunityOutreachReportsScreen extends StatelessWidget {
  const CommunityOutreachReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_reports',
      title: 'Community Outreach Reports',
      child: Column(
        children: const [
          const CommunityOutreachReportsHeaderSection(),
          const CommunityOutreachReportsFilterBarSection(),
          const CommunityOutreachReportsMetricsSummarySection(),
          const CommunityOutreachReportsChartAreaSection(),
          const CommunityOutreachReportsExportActionsSection(),
        ],
      ),
    );
  }
}
