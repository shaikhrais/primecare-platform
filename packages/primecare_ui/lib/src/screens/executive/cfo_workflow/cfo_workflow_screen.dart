import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_workflow_screen_controller.dart';
import 'sections/cfo_workflow_header_section.dart';
import 'sections/cfo_workflow_task_filters_section.dart';
import 'sections/cfo_workflow_task_list_section.dart';
import 'sections/cfo_workflow_task_details_section.dart';
import 'sections/cfo_workflow_action_bar_section.dart';


class CfoWorkflowScreen extends ConsumerWidget {
  const CfoWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_workflow_loading'), child: Semantics(label: 'cfo_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_workflow_screen'),
                    child: Column(
                      children: [
                        CfoWorkflowHeaderSection(data: state.data),
                        CfoWorkflowTaskFiltersSection(data: state.data),
                        CfoWorkflowTaskListSection(data: state.data),
                        CfoWorkflowTaskDetailsSection(data: state.data),
                        CfoWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
