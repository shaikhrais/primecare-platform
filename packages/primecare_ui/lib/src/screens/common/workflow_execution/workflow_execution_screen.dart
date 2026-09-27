import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'workflow_execution_screen_controller.dart';
import 'sections/workflow_execution_header_section.dart';
import 'sections/workflow_execution_task_filters_section.dart';
import 'sections/workflow_execution_task_list_section.dart';
import 'sections/workflow_execution_task_details_section.dart';
import 'sections/workflow_execution_action_bar_section.dart';


class WorkflowExecutionScreen extends ConsumerWidget {
  const WorkflowExecutionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workflow_executionControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('WorkflowExecution'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(workflow_executionControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('workflow_execution_loading'), child: Semantics(label: 'workflow_execution_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('workflow_execution_screen'),
                    child: Column(
                      children: [
                        WorkflowExecutionHeaderSection(data: state.data),
                        WorkflowExecutionTaskFiltersSection(data: state.data),
                        WorkflowExecutionTaskListSection(data: state.data),
                        WorkflowExecutionTaskDetailsSection(data: state.data),
                        WorkflowExecutionActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
