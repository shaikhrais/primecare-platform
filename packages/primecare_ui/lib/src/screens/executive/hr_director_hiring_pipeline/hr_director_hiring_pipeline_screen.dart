import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_director_hiring_pipeline_screen_controller.dart';
import 'sections/hr_director_hiring_pipeline_header_section.dart';
import 'sections/hr_director_hiring_pipeline_content_summary_section.dart';
import 'sections/hr_director_hiring_pipeline_primary_content_section.dart';
import 'sections/hr_director_hiring_pipeline_action_bar_section.dart';


class HrDirectorHiringPipelineScreen extends ConsumerWidget {
  const HrDirectorHiringPipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_director_hiring_pipelineControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrDirectorHiringPipeline'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_director_hiring_pipelineControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_director_hiring_pipeline_loading'), child: Semantics(label: 'hr_director_hiring_pipeline_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_director_hiring_pipeline_screen'),
                    child: Column(
                      children: [
                        HrDirectorHiringPipelineHeaderSection(data: state.data),
                        HrDirectorHiringPipelineContentSummarySection(data: state.data),
                        HrDirectorHiringPipelinePrimaryContentSection(data: state.data),
                        HrDirectorHiringPipelineActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
