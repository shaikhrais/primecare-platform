import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinic_workflow_screen_controller.dart';
import 'sections/clinic_workflow_header_section.dart';
import 'sections/clinic_workflow_task_filters_section.dart';
import 'sections/clinic_workflow_task_list_section.dart';
import 'sections/clinic_workflow_task_details_section.dart';
import 'sections/clinic_workflow_action_bar_section.dart';


class ClinicWorkflowScreen extends ConsumerWidget {
  const ClinicWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinic_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinic_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinic_workflow_loading'), child: Semantics(label: 'clinic_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinic_workflow_screen'),
                    child: Column(
                      children: [
                        ClinicWorkflowHeaderSection(data: state.data),
                        ClinicWorkflowTaskFiltersSection(data: state.data),
                        ClinicWorkflowTaskListSection(data: state.data),
                        ClinicWorkflowTaskDetailsSection(data: state.data),
                        ClinicWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
