import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/pediatric_analytics_header_section.dart';
import 'sections/pediatric_analytics_filter_bar_section.dart';
import 'sections/pediatric_analytics_metrics_summary_section.dart';
import 'sections/pediatric_analytics_chart_area_section.dart';
import 'sections/pediatric_analytics_export_actions_section.dart';

class PediatricAnalyticsScreen extends StatelessWidget {
  const PediatricAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'pediatric_analytics',
      title: 'Pediatric Specialist Analytics',
      child: Column(
        children: const [
          const PediatricAnalyticsHeaderSection(),
          const PediatricAnalyticsFilterBarSection(),
          const PediatricAnalyticsMetricsSummarySection(),
          const PediatricAnalyticsChartAreaSection(),
          const PediatricAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}

typedef PediatricSpecialistAnalyticsScreen = PediatricAnalyticsScreen;
