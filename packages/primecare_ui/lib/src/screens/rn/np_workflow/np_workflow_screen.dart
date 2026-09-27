import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'np_workflow_screen_controller.dart';
import 'sections/np_workflow_header_section.dart';
import 'sections/np_workflow_task_filters_section.dart';
import 'sections/np_workflow_task_list_section.dart';
import 'sections/np_workflow_task_details_section.dart';
import 'sections/np_workflow_action_bar_section.dart';


class NursePractitionerNpComplianceWorkflowScreen extends ConsumerWidget {
  const NursePractitionerNpComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(np_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Nurse Practitioner (NP) Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(np_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('np_workflow_loading'), child: Semantics(label: 'np_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('np_workflow_screen'),
                    child: Column(
                      children: [
                        NpWorkflowHeaderSection(data: state.data),
                        NpWorkflowTaskFiltersSection(data: state.data),
                        NpWorkflowTaskListSection(data: state.data),
                        NpWorkflowTaskDetailsSection(data: state.data),
                        NpWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef NursePractitionerNPComplianceWorkflowScreen = NursePractitionerNpComplianceWorkflowScreen;
