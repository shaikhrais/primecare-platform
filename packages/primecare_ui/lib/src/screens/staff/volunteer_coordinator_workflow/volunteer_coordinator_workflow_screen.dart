import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'volunteer_coordinator_workflow_screen_controller.dart';
import 'sections/volunteer_coordinator_workflow_header_section.dart';
import 'sections/volunteer_coordinator_workflow_task_filters_section.dart';
import 'sections/volunteer_coordinator_workflow_task_list_section.dart';
import 'sections/volunteer_coordinator_workflow_task_details_section.dart';
import 'sections/volunteer_coordinator_workflow_action_bar_section.dart';


class VolunteerCoordinatorWorkflowScreen extends ConsumerWidget {
  const VolunteerCoordinatorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(volunteer_coordinator_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('VolunteerCoordinatorWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(volunteer_coordinator_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('volunteer_coordinator_workflow_loading'), child: Semantics(label: 'volunteer_coordinator_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('volunteer_coordinator_workflow_screen'),
                    child: Column(
                      children: [
                        VolunteerCoordinatorWorkflowHeaderSection(data: state.data),
                        VolunteerCoordinatorWorkflowTaskFiltersSection(data: state.data),
                        VolunteerCoordinatorWorkflowTaskListSection(data: state.data),
                        VolunteerCoordinatorWorkflowTaskDetailsSection(data: state.data),
                        VolunteerCoordinatorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
