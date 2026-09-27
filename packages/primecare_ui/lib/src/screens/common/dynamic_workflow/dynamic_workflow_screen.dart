import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dynamic_workflow_screen_controller.dart';
import 'sections/dynamic_workflow_header_section.dart';
import 'sections/dynamic_workflow_task_filters_section.dart';
import 'sections/dynamic_workflow_task_list_section.dart';
import 'sections/dynamic_workflow_task_details_section.dart';
import 'sections/dynamic_workflow_action_bar_section.dart';


class DynamicScreenWorkflowScreen extends ConsumerWidget {
  const DynamicScreenWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamic_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('DynamicWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(dynamic_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('dynamic_workflow_loading'), child: Semantics(label: 'dynamic_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('dynamic_workflow_screen'),
                    child: Column(
                      children: [
                        DynamicWorkflowHeaderSection(data: state.data),
                        DynamicWorkflowTaskFiltersSection(data: state.data),
                        DynamicWorkflowTaskListSection(data: state.data),
                        DynamicWorkflowTaskDetailsSection(data: state.data),
                        DynamicWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
