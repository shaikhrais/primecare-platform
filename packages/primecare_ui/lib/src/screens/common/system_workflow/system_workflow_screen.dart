import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'system_workflow_screen_controller.dart';
import 'sections/system_workflow_header_section.dart';
import 'sections/system_workflow_task_filters_section.dart';
import 'sections/system_workflow_task_list_section.dart';
import 'sections/system_workflow_task_details_section.dart';
import 'sections/system_workflow_action_bar_section.dart';


class SystemWorkflowScreen extends ConsumerWidget {
  const SystemWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(system_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SystemWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(system_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('system_workflow_loading'), child: Semantics(label: 'system_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('system_workflow_screen'),
                    child: Column(
                      children: [
                        SystemWorkflowHeaderSection(data: state.data),
                        SystemWorkflowTaskFiltersSection(data: state.data),
                        SystemWorkflowTaskListSection(data: state.data),
                        SystemWorkflowTaskDetailsSection(data: state.data),
                        SystemWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
