import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'receptionist_workflow_screen_controller.dart';
import 'sections/receptionist_workflow_header_section.dart';
import 'sections/receptionist_workflow_task_filters_section.dart';
import 'sections/receptionist_workflow_task_list_section.dart';
import 'sections/receptionist_workflow_task_details_section.dart';
import 'sections/receptionist_workflow_action_bar_section.dart';


class ReceptionistWorkflowScreen extends ConsumerWidget {
  const ReceptionistWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(receptionist_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ReceptionistWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(receptionist_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('receptionist_workflow_loading'), child: Semantics(label: 'receptionist_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('receptionist_workflow_screen'),
                    child: Column(
                      children: [
                        ReceptionistWorkflowHeaderSection(data: state.data),
                        ReceptionistWorkflowTaskFiltersSection(data: state.data),
                        ReceptionistWorkflowTaskListSection(data: state.data),
                        ReceptionistWorkflowTaskDetailsSection(data: state.data),
                        ReceptionistWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
