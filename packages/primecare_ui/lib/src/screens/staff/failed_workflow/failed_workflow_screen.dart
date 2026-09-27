import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'failed_workflow_screen_controller.dart';
import 'sections/failed_workflow_header_section.dart';
import 'sections/failed_workflow_task_filters_section.dart';
import 'sections/failed_workflow_task_list_section.dart';
import 'sections/failed_workflow_task_details_section.dart';
import 'sections/failed_workflow_action_bar_section.dart';


class FailedWorkflowScreen extends ConsumerWidget {
  const FailedWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(failed_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FailedWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(failed_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('failed_workflow_loading'), child: Semantics(label: 'failed_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('failed_workflow_screen'),
                    child: Column(
                      children: [
                        FailedWorkflowHeaderSection(data: state.data),
                        FailedWorkflowTaskFiltersSection(data: state.data),
                        FailedWorkflowTaskListSection(data: state.data),
                        FailedWorkflowTaskDetailsSection(data: state.data),
                        FailedWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
