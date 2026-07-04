import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/population_health_analyzer_header_section.dart';
import 'sections/population_health_analyzer_content_summary_section.dart';
import 'sections/population_health_analyzer_primary_content_section.dart';
import 'sections/population_health_analyzer_action_bar_section.dart';

class PopulationHealthAnalyzerScreen extends StatelessWidget {
  const PopulationHealthAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'population_health_analyzer',
      title: 'Population Health Analyzer',
      child: Column(
        children: const [
          const PopulationHealthAnalyzerHeaderSection(),
          const PopulationHealthAnalyzerContentSummarySection(),
          const PopulationHealthAnalyzerPrimaryContentSection(),
          const PopulationHealthAnalyzerActionBarSection(),
        ],
      ),
    );
  }
}
