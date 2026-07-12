import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_workflow_screen_controller.dart';
import 'sections/patient_workflow_header_section.dart';
import 'sections/patient_workflow_task_filters_section.dart';
import 'sections/patient_workflow_task_list_section.dart';
import 'sections/patient_workflow_task_details_section.dart';
import 'sections/patient_workflow_action_bar_section.dart';


class PatientWorkflowScreen extends ConsumerWidget {
  const PatientWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_workflow_loading'), child: Semantics(label: 'patient_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_workflow_screen'),
                    child: Column(
                      children: [
                        PatientWorkflowHeaderSection(data: state.data),
                        PatientWorkflowTaskFiltersSection(data: state.data),
                        PatientWorkflowTaskListSection(data: state.data),
                        PatientWorkflowTaskDetailsSection(data: state.data),
                        PatientWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
