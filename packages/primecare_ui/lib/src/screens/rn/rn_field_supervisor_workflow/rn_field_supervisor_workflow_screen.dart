import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_field_supervisor_workflow_screen_controller.dart';
import 'sections/rn_field_supervisor_workflow_header_section.dart';
import 'sections/rn_field_supervisor_workflow_task_filters_section.dart';
import 'sections/rn_field_supervisor_workflow_task_list_section.dart';
import 'sections/rn_field_supervisor_workflow_task_details_section.dart';
import 'sections/rn_field_supervisor_workflow_action_bar_section.dart';


class RegisteredNurseRnFieldSupervisorComplianceWorkflowScreen extends ConsumerWidget {
  const RegisteredNurseRnFieldSupervisorComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_field_supervisor_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Registered Nurse (RN) Field Supervisor Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_field_supervisor_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_field_supervisor_workflow_loading'), child: Semantics(label: 'rn_field_supervisor_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_field_supervisor_workflow_screen'),
                    child: Column(
                      children: [
                        RnFieldSupervisorWorkflowHeaderSection(data: state.data),
                        RnFieldSupervisorWorkflowTaskFiltersSection(data: state.data),
                        RnFieldSupervisorWorkflowTaskListSection(data: state.data),
                        RnFieldSupervisorWorkflowTaskDetailsSection(data: state.data),
                        RnFieldSupervisorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
