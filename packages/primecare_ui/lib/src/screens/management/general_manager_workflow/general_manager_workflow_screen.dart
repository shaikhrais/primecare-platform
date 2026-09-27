import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'general_manager_workflow_screen_controller.dart';
import 'sections/general_manager_workflow_header_section.dart';
import 'sections/general_manager_workflow_task_filters_section.dart';
import 'sections/general_manager_workflow_task_list_section.dart';
import 'sections/general_manager_workflow_task_details_section.dart';
import 'sections/general_manager_workflow_action_bar_section.dart';


class GeneralManagerWorkflowScreen extends ConsumerWidget {
  const GeneralManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(general_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GeneralManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(general_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('general_manager_workflow_loading'), child: Semantics(label: 'general_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('general_manager_workflow_screen'),
                    child: Column(
                      children: [
                        GeneralManagerWorkflowHeaderSection(data: state.data),
                        GeneralManagerWorkflowTaskFiltersSection(data: state.data),
                        GeneralManagerWorkflowTaskListSection(data: state.data),
                        GeneralManagerWorkflowTaskDetailsSection(data: state.data),
                        GeneralManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
