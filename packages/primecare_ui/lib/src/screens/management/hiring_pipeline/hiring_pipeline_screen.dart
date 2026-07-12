import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hiring_pipeline_screen_controller.dart';
import 'sections/hiring_pipeline_header_section.dart';
import 'sections/hiring_pipeline_content_summary_section.dart';
import 'sections/hiring_pipeline_primary_content_section.dart';
import 'sections/hiring_pipeline_action_bar_section.dart';


class HiringPipelineScreen extends ConsumerWidget {
  const HiringPipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hiring_pipelineControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HiringPipeline'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hiring_pipelineControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hiring_pipeline_loading'), child: Semantics(label: 'hiring_pipeline_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hiring_pipeline_screen'),
                    child: Column(
                      children: [
                        HiringPipelineHeaderSection(data: state.data),
                        HiringPipelineContentSummarySection(data: state.data),
                        HiringPipelinePrimaryContentSection(data: state.data),
                        HiringPipelineActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
