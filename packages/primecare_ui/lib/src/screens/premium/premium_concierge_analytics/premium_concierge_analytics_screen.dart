import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/premium_concierge_analytics_header_section.dart';
import 'sections/premium_concierge_analytics_filter_bar_section.dart';
import 'sections/premium_concierge_analytics_metrics_summary_section.dart';
import 'sections/premium_concierge_analytics_chart_area_section.dart';
import 'sections/premium_concierge_analytics_export_actions_section.dart';

class PremiumConciergeAnalyticsScreen extends StatelessWidget {
  const PremiumConciergeAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'premium_concierge_analytics',
      title: 'Premium Concierge Care Coordinator Analytics',
      child: Column(
        children: const [
          const PremiumConciergeAnalyticsHeaderSection(),
          const PremiumConciergeAnalyticsFilterBarSection(),
          const PremiumConciergeAnalyticsMetricsSummarySection(),
          const PremiumConciergeAnalyticsChartAreaSection(),
          const PremiumConciergeAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}

typedef PremiumConciergeCareCoordinatorAnalyticsScreen = PremiumConciergeAnalyticsScreen;
