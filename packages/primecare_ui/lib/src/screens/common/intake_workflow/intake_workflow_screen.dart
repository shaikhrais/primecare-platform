import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_workflow_screen_controller.dart';
import 'sections/intake_workflow_header_section.dart';
import 'sections/intake_workflow_task_filters_section.dart';
import 'sections/intake_workflow_task_list_section.dart';
import 'sections/intake_workflow_task_details_section.dart';
import 'sections/intake_workflow_action_bar_section.dart';


class IntakeWorkflowScreen extends ConsumerWidget {
  const IntakeWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_workflow_loading'), child: Semantics(label: 'intake_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_workflow_screen'),
                    child: Column(
                      children: [
                        IntakeWorkflowHeaderSection(data: state.data),
                        IntakeWorkflowTaskFiltersSection(data: state.data),
                        IntakeWorkflowTaskListSection(data: state.data),
                        IntakeWorkflowTaskDetailsSection(data: state.data),
                        IntakeWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
