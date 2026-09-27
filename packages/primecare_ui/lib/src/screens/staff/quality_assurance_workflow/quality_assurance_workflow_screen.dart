import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'quality_assurance_workflow_screen_controller.dart';
import 'sections/quality_assurance_workflow_header_section.dart';
import 'sections/quality_assurance_workflow_task_filters_section.dart';
import 'sections/quality_assurance_workflow_task_list_section.dart';
import 'sections/quality_assurance_workflow_task_details_section.dart';
import 'sections/quality_assurance_workflow_action_bar_section.dart';


class QualityAssuranceWorkflowScreen extends ConsumerWidget {
  const QualityAssuranceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quality_assurance_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('QualityAssuranceWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(quality_assurance_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('quality_assurance_workflow_loading'), child: Semantics(label: 'quality_assurance_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('quality_assurance_workflow_screen'),
                    child: Column(
                      children: [
                        QualityAssuranceWorkflowHeaderSection(data: state.data),
                        QualityAssuranceWorkflowTaskFiltersSection(data: state.data),
                        QualityAssuranceWorkflowTaskListSection(data: state.data),
                        QualityAssuranceWorkflowTaskDetailsSection(data: state.data),
                        QualityAssuranceWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
