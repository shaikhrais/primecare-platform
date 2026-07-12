import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'operations_manager_workflow_screen_controller.dart';
import 'sections/operations_manager_workflow_header_section.dart';
import 'sections/operations_manager_workflow_task_filters_section.dart';
import 'sections/operations_manager_workflow_task_list_section.dart';
import 'sections/operations_manager_workflow_task_details_section.dart';
import 'sections/operations_manager_workflow_action_bar_section.dart';


class OperationsManagerWorkflowScreen extends ConsumerWidget {
  const OperationsManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operations_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OperationsManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(operations_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('operations_manager_workflow_loading'), child: Semantics(label: 'operations_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('operations_manager_workflow_screen'),
                    child: Column(
                      children: [
                        OperationsManagerWorkflowHeaderSection(data: state.data),
                        OperationsManagerWorkflowTaskFiltersSection(data: state.data),
                        OperationsManagerWorkflowTaskListSection(data: state.data),
                        OperationsManagerWorkflowTaskDetailsSection(data: state.data),
                        OperationsManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
