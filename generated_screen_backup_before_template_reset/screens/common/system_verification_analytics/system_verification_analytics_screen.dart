import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_verification_analytics_header_section.dart';
import 'sections/system_verification_analytics_filter_bar_section.dart';
import 'sections/system_verification_analytics_metrics_summary_section.dart';
import 'sections/system_verification_analytics_chart_area_section.dart';
import 'sections/system_verification_analytics_export_actions_section.dart';

class SystemVerificationAnalyticsScreen extends StatelessWidget {
  const SystemVerificationAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_verification_analytics',
      title: 'SystemVerificationAnalyticsScreen',
      child: Column(
        children: const [
          const SystemVerificationAnalyticsHeaderSection(),
          const SystemVerificationAnalyticsFilterBarSection(),
          const SystemVerificationAnalyticsMetricsSummarySection(),
          const SystemVerificationAnalyticsChartAreaSection(),
          const SystemVerificationAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
