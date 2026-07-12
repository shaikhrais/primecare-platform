import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'infrastructure_workflow_screen_controller.dart';
import 'sections/infrastructure_workflow_header_section.dart';
import 'sections/infrastructure_workflow_task_filters_section.dart';
import 'sections/infrastructure_workflow_task_list_section.dart';
import 'sections/infrastructure_workflow_task_details_section.dart';
import 'sections/infrastructure_workflow_action_bar_section.dart';


class InfrastructureWorkflowScreen extends ConsumerWidget {
  const InfrastructureWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infrastructure_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('InfrastructureWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(infrastructure_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('infrastructure_workflow_loading'), child: Semantics(label: 'infrastructure_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('infrastructure_workflow_screen'),
                    child: Column(
                      children: [
                        InfrastructureWorkflowHeaderSection(data: state.data),
                        InfrastructureWorkflowTaskFiltersSection(data: state.data),
                        InfrastructureWorkflowTaskListSection(data: state.data),
                        InfrastructureWorkflowTaskDetailsSection(data: state.data),
                        InfrastructureWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
