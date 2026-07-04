import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/receptionist_analytics_header_section.dart';
import 'sections/receptionist_analytics_filter_bar_section.dart';
import 'sections/receptionist_analytics_metrics_summary_section.dart';
import 'sections/receptionist_analytics_chart_area_section.dart';
import 'sections/receptionist_analytics_export_actions_section.dart';

class ReceptionistAnalyticsScreen extends StatelessWidget {
  const ReceptionistAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'receptionist_analytics',
      title: 'ReceptionistAnalyticsScreen',
      child: Column(
        children: const [
          const ReceptionistAnalyticsHeaderSection(),
          const ReceptionistAnalyticsFilterBarSection(),
          const ReceptionistAnalyticsMetricsSummarySection(),
          const ReceptionistAnalyticsChartAreaSection(),
          const ReceptionistAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
