import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cto_workflow_screen_controller.dart';
import 'sections/cto_workflow_header_section.dart';
import 'sections/cto_workflow_task_filters_section.dart';
import 'sections/cto_workflow_task_list_section.dart';
import 'sections/cto_workflow_task_details_section.dart';
import 'sections/cto_workflow_action_bar_section.dart';


class CtoWorkflowScreen extends ConsumerWidget {
  const CtoWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cto_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CtoWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cto_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cto_workflow_loading'), child: Semantics(label: 'cto_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cto_workflow_screen'),
                    child: Column(
                      children: [
                        CtoWorkflowHeaderSection(data: state.data),
                        CtoWorkflowTaskFiltersSection(data: state.data),
                        CtoWorkflowTaskListSection(data: state.data),
                        CtoWorkflowTaskDetailsSection(data: state.data),
                        CtoWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
