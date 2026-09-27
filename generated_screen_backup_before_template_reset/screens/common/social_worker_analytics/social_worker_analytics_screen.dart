import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/social_worker_analytics_header_section.dart';
import 'sections/social_worker_analytics_filter_bar_section.dart';
import 'sections/social_worker_analytics_metrics_summary_section.dart';
import 'sections/social_worker_analytics_chart_area_section.dart';
import 'sections/social_worker_analytics_export_actions_section.dart';

class SocialWorkerAnalyticsScreen extends StatelessWidget {
  const SocialWorkerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'social_worker_analytics',
      title: 'SocialWorkerAnalyticsScreen',
      child: Column(
        children: const [
          const SocialWorkerAnalyticsHeaderSection(),
          const SocialWorkerAnalyticsFilterBarSection(),
          const SocialWorkerAnalyticsMetricsSummarySection(),
          const SocialWorkerAnalyticsChartAreaSection(),
          const SocialWorkerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
