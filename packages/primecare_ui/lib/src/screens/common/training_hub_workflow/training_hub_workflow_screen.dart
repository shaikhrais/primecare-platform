import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_hub_workflow_screen_controller.dart';
import 'sections/training_hub_workflow_header_section.dart';
import 'sections/training_hub_workflow_task_filters_section.dart';
import 'sections/training_hub_workflow_task_list_section.dart';
import 'sections/training_hub_workflow_task_details_section.dart';
import 'sections/training_hub_workflow_action_bar_section.dart';


class TrainingHubWorkflowScreen extends ConsumerWidget {
  const TrainingHubWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_hub_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingHubWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_hub_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_hub_workflow_loading'), child: Semantics(label: 'training_hub_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_hub_workflow_screen'),
                    child: Column(
                      children: [
                        TrainingHubWorkflowHeaderSection(data: state.data),
                        TrainingHubWorkflowTaskFiltersSection(data: state.data),
                        TrainingHubWorkflowTaskListSection(data: state.data),
                        TrainingHubWorkflowTaskDetailsSection(data: state.data),
                        TrainingHubWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
