import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_strategic_kpis_header_section.dart';
import 'sections/ceo_strategic_kpis_filter_bar_section.dart';
import 'sections/ceo_strategic_kpis_metrics_summary_section.dart';
import 'sections/ceo_strategic_kpis_chart_area_section.dart';
import 'sections/ceo_strategic_kpis_export_actions_section.dart';

class CeoStrategicKpisScreen extends StatelessWidget {
  const CeoStrategicKpisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_strategic_kpis',
      title: 'Ceo Strategic Kpis',
      child: Column(
        children: const [
          const CeoStrategicKpisHeaderSection(),
          const CeoStrategicKpisFilterBarSection(),
          const CeoStrategicKpisMetricsSummarySection(),
          const CeoStrategicKpisChartAreaSection(),
          const CeoStrategicKpisExportActionsSection(),
        ],
      ),
    );
  }
}
