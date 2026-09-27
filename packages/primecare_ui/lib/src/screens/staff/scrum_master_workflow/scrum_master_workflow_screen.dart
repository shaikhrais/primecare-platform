import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scrum_master_workflow_screen_controller.dart';
import 'sections/scrum_master_workflow_header_section.dart';
import 'sections/scrum_master_workflow_task_filters_section.dart';
import 'sections/scrum_master_workflow_task_list_section.dart';
import 'sections/scrum_master_workflow_task_details_section.dart';
import 'sections/scrum_master_workflow_action_bar_section.dart';


class ScrumMasterWorkflowScreen extends ConsumerWidget {
  const ScrumMasterWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scrum_master_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ScrumMasterWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scrum_master_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scrum_master_workflow_loading'), child: Semantics(label: 'scrum_master_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scrum_master_workflow_screen'),
                    child: Column(
                      children: [
                        ScrumMasterWorkflowHeaderSection(data: state.data),
                        ScrumMasterWorkflowTaskFiltersSection(data: state.data),
                        ScrumMasterWorkflowTaskListSection(data: state.data),
                        ScrumMasterWorkflowTaskDetailsSection(data: state.data),
                        ScrumMasterWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
