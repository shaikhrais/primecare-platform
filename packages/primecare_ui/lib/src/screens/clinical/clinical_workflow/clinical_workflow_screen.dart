import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_workflow_screen_controller.dart';
import 'sections/clinical_workflow_header_section.dart';
import 'sections/clinical_workflow_task_filters_section.dart';
import 'sections/clinical_workflow_task_list_section.dart';
import 'sections/clinical_workflow_task_details_section.dart';
import 'sections/clinical_workflow_action_bar_section.dart';


class ClinicalWorkflowScreen extends ConsumerWidget {
  const ClinicalWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_workflow_loading'), child: Semantics(label: 'clinical_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_workflow_screen'),
                    child: Column(
                      children: [
                        ClinicalWorkflowHeaderSection(data: state.data),
                        ClinicalWorkflowTaskFiltersSection(data: state.data),
                        ClinicalWorkflowTaskListSection(data: state.data),
                        ClinicalWorkflowTaskDetailsSection(data: state.data),
                        ClinicalWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
