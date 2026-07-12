import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_workflow_screen_controller.dart';
import 'sections/intake_coordinator_workflow_header_section.dart';
import 'sections/intake_coordinator_workflow_task_filters_section.dart';
import 'sections/intake_coordinator_workflow_task_list_section.dart';
import 'sections/intake_coordinator_workflow_task_details_section.dart';
import 'sections/intake_coordinator_workflow_action_bar_section.dart';


class IntakeCoordinatorWorkflowScreen extends ConsumerWidget {
  const IntakeCoordinatorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_coordinator_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCoordinatorWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_coordinator_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_coordinator_workflow_loading'), child: Semantics(label: 'intake_coordinator_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_coordinator_workflow_screen'),
                    child: Column(
                      children: [
                        IntakeCoordinatorWorkflowHeaderSection(data: state.data),
                        IntakeCoordinatorWorkflowTaskFiltersSection(data: state.data),
                        IntakeCoordinatorWorkflowTaskListSection(data: state.data),
                        IntakeCoordinatorWorkflowTaskDetailsSection(data: state.data),
                        IntakeCoordinatorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
