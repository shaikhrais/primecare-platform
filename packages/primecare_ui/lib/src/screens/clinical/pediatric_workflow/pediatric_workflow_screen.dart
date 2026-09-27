import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'pediatric_workflow_screen_controller.dart';
import 'sections/pediatric_workflow_header_section.dart';
import 'sections/pediatric_workflow_task_filters_section.dart';
import 'sections/pediatric_workflow_task_list_section.dart';
import 'sections/pediatric_workflow_task_details_section.dart';
import 'sections/pediatric_workflow_action_bar_section.dart';


class PediatricSpecialistComplianceWorkflowScreen extends ConsumerWidget {
  const PediatricSpecialistComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pediatric_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Pediatric Specialist Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(pediatric_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('pediatric_workflow_loading'), child: Semantics(label: 'pediatric_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('pediatric_workflow_screen'),
                    child: Column(
                      children: [
                        PediatricWorkflowHeaderSection(data: state.data),
                        PediatricWorkflowTaskFiltersSection(data: state.data),
                        PediatricWorkflowTaskListSection(data: state.data),
                        PediatricWorkflowTaskDetailsSection(data: state.data),
                        PediatricWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
