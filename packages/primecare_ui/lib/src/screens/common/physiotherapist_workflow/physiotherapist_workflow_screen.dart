import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_workflow_screen_controller.dart';
import 'sections/physiotherapist_workflow_header_section.dart';
import 'sections/physiotherapist_workflow_task_filters_section.dart';
import 'sections/physiotherapist_workflow_task_list_section.dart';
import 'sections/physiotherapist_workflow_task_details_section.dart';
import 'sections/physiotherapist_workflow_action_bar_section.dart';


class PhysiotherapistWorkflowScreen extends ConsumerWidget {
  const PhysiotherapistWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_workflow_loading'), child: Semantics(label: 'physiotherapist_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_workflow_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistWorkflowHeaderSection(data: state.data),
                        PhysiotherapistWorkflowTaskFiltersSection(data: state.data),
                        PhysiotherapistWorkflowTaskListSection(data: state.data),
                        PhysiotherapistWorkflowTaskDetailsSection(data: state.data),
                        PhysiotherapistWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
