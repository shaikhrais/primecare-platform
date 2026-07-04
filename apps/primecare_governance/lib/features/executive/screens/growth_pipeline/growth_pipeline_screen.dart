import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/growth_pipeline_header_section.dart';
import 'sections/growth_pipeline_content_summary_section.dart';
import 'sections/growth_pipeline_primary_content_section.dart';
import 'sections/growth_pipeline_action_bar_section.dart';

class GrowthPipelineScreen extends StatelessWidget {
  const GrowthPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'growth_pipeline',
      title: 'Growth Pipeline',
      child: Column(
        children: const [
          const GrowthPipelineHeaderSection(),
          const GrowthPipelineContentSummarySection(),
          const GrowthPipelinePrimaryContentSection(),
          const GrowthPipelineActionBarSection(),
        ],
      ),
    );
  }
}
