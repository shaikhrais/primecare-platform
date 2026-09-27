import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_analytics_header_section.dart';
import 'sections/community_outreach_analytics_filter_bar_section.dart';
import 'sections/community_outreach_analytics_metrics_summary_section.dart';
import 'sections/community_outreach_analytics_chart_area_section.dart';
import 'sections/community_outreach_analytics_export_actions_section.dart';

class CommunityOutreachAnalyticsScreen extends StatelessWidget {
  const CommunityOutreachAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_analytics',
      title: 'CommunityOutreachAnalyticsScreen',
      child: Column(
        children: const [
          const CommunityOutreachAnalyticsHeaderSection(),
          const CommunityOutreachAnalyticsFilterBarSection(),
          const CommunityOutreachAnalyticsMetricsSummarySection(),
          const CommunityOutreachAnalyticsChartAreaSection(),
          const CommunityOutreachAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
