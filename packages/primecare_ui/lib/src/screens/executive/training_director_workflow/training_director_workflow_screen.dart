import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_director_workflow_screen_controller.dart';
import 'sections/training_director_workflow_header_section.dart';
import 'sections/training_director_workflow_task_filters_section.dart';
import 'sections/training_director_workflow_task_list_section.dart';
import 'sections/training_director_workflow_task_details_section.dart';
import 'sections/training_director_workflow_action_bar_section.dart';


class TrainingDirectorWorkflowScreen extends ConsumerWidget {
  const TrainingDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_director_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingDirectorWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_director_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_director_workflow_loading'), child: Semantics(label: 'training_director_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_director_workflow_screen'),
                    child: Column(
                      children: [
                        TrainingDirectorWorkflowHeaderSection(data: state.data),
                        TrainingDirectorWorkflowTaskFiltersSection(data: state.data),
                        TrainingDirectorWorkflowTaskListSection(data: state.data),
                        TrainingDirectorWorkflowTaskDetailsSection(data: state.data),
                        TrainingDirectorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
