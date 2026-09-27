import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_hiring_pipeline_header_section.dart';
import 'sections/hr_director_hiring_pipeline_content_summary_section.dart';
import 'sections/hr_director_hiring_pipeline_primary_content_section.dart';
import 'sections/hr_director_hiring_pipeline_action_bar_section.dart';

class HrDirectorHiringPipelineScreen extends StatelessWidget {
  const HrDirectorHiringPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_hiring_pipeline',
      title: 'HrDirectorHiringPipelineScreen',
      child: Column(
        children: const [
          const HrDirectorHiringPipelineHeaderSection(),
          const HrDirectorHiringPipelineContentSummarySection(),
          const HrDirectorHiringPipelinePrimaryContentSection(),
          const HrDirectorHiringPipelineActionBarSection(),
        ],
      ),
    );
  }
}
