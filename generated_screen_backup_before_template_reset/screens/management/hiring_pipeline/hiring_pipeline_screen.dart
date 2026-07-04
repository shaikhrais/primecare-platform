import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hiring_pipeline_header_section.dart';
import 'sections/hiring_pipeline_content_summary_section.dart';
import 'sections/hiring_pipeline_primary_content_section.dart';
import 'sections/hiring_pipeline_action_bar_section.dart';

class HiringPipelineScreen extends StatelessWidget {
  const HiringPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hiring_pipeline',
      title: 'HiringPipelineScreen',
      child: Column(
        children: const [
          const HiringPipelineHeaderSection(),
          const HiringPipelineContentSummarySection(),
          const HiringPipelinePrimaryContentSection(),
          const HiringPipelineActionBarSection(),
        ],
      ),
    );
  }
}
