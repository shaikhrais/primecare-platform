import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_growth_pipeline_header_section.dart';
import 'sections/ceo_growth_pipeline_content_summary_section.dart';
import 'sections/ceo_growth_pipeline_primary_content_section.dart';
import 'sections/ceo_growth_pipeline_action_bar_section.dart';

class CeoGrowthPipelineScreen extends StatelessWidget {
  const CeoGrowthPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_growth_pipeline',
      title: 'Ceo Growth Pipeline',
      child: Column(
        children: const [
          const CeoGrowthPipelineHeaderSection(),
          const CeoGrowthPipelineContentSummarySection(),
          const CeoGrowthPipelinePrimaryContentSection(),
          const CeoGrowthPipelineActionBarSection(),
        ],
      ),
    );
  }
}
