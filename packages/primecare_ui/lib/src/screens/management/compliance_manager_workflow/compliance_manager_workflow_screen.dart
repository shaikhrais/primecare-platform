import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'compliance_manager_workflow_screen_controller.dart';
import 'sections/compliance_manager_workflow_header_section.dart';
import 'sections/compliance_manager_workflow_task_filters_section.dart';
import 'sections/compliance_manager_workflow_task_list_section.dart';
import 'sections/compliance_manager_workflow_task_details_section.dart';
import 'sections/compliance_manager_workflow_action_bar_section.dart';


class ComplianceManagerWorkflowScreen extends ConsumerWidget {
  const ComplianceManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compliance_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ComplianceManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(compliance_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('compliance_manager_workflow_loading'), child: Semantics(label: 'compliance_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('compliance_manager_workflow_screen'),
                    child: Column(
                      children: [
                        ComplianceManagerWorkflowHeaderSection(data: state.data),
                        ComplianceManagerWorkflowTaskFiltersSection(data: state.data),
                        ComplianceManagerWorkflowTaskListSection(data: state.data),
                        ComplianceManagerWorkflowTaskDetailsSection(data: state.data),
                        ComplianceManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
