import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'office_workflow_screen_controller.dart';
import 'sections/office_workflow_header_section.dart';
import 'sections/office_workflow_task_filters_section.dart';
import 'sections/office_workflow_task_list_section.dart';
import 'sections/office_workflow_task_details_section.dart';
import 'sections/office_workflow_action_bar_section.dart';


class OfficeWorkflowScreen extends ConsumerWidget {
  const OfficeWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(office_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OfficeWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(office_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('office_workflow_loading'), child: Semantics(label: 'office_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('office_workflow_screen'),
                    child: Column(
                      children: [
                        OfficeWorkflowHeaderSection(data: state.data),
                        OfficeWorkflowTaskFiltersSection(data: state.data),
                        OfficeWorkflowTaskListSection(data: state.data),
                        OfficeWorkflowTaskDetailsSection(data: state.data),
                        OfficeWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
