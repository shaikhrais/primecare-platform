import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/board_of_directors_summary_header_section.dart';
import 'sections/board_of_directors_summary_filter_bar_section.dart';
import 'sections/board_of_directors_summary_metrics_summary_section.dart';
import 'sections/board_of_directors_summary_chart_area_section.dart';
import 'sections/board_of_directors_summary_export_actions_section.dart';

class BoardOfDirectorsSummaryScreen extends StatelessWidget {
  const BoardOfDirectorsSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'board_of_directors_summary',
      title: 'Board Of Directors Summary',
      child: Column(
        children: const [
          const BoardOfDirectorsSummaryHeaderSection(),
          const BoardOfDirectorsSummaryFilterBarSection(),
          const BoardOfDirectorsSummaryMetricsSummarySection(),
          const BoardOfDirectorsSummaryChartAreaSection(),
          const BoardOfDirectorsSummaryExportActionsSection(),
        ],
      ),
    );
  }
}
