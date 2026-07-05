import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/vip_manager_analytics_header_section.dart';
import 'sections/vip_manager_analytics_filter_bar_section.dart';
import 'sections/vip_manager_analytics_metrics_summary_section.dart';
import 'sections/vip_manager_analytics_chart_area_section.dart';
import 'sections/vip_manager_analytics_export_actions_section.dart';

class VipManagerAnalyticsScreen extends StatelessWidget {
  const VipManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'vip_manager_analytics',
      title: 'VIP Client Manager Analytics',
      child: Column(
        children: const [
          const VipManagerAnalyticsHeaderSection(),
          const VipManagerAnalyticsFilterBarSection(),
          const VipManagerAnalyticsMetricsSummarySection(),
          const VipManagerAnalyticsChartAreaSection(),
          const VipManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}

typedef VIPClientManagerAnalyticsScreen = VipManagerAnalyticsScreen;
