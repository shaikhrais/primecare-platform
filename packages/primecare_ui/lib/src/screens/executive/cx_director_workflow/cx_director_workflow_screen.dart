import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cx_director_workflow_screen_controller.dart';
import 'sections/cx_director_workflow_header_section.dart';
import 'sections/cx_director_workflow_task_filters_section.dart';
import 'sections/cx_director_workflow_task_list_section.dart';
import 'sections/cx_director_workflow_task_details_section.dart';
import 'sections/cx_director_workflow_action_bar_section.dart';


class CxDirectorWorkflowScreen extends ConsumerWidget {
  const CxDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cx_director_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CxDirectorWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cx_director_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cx_director_workflow_loading'), child: Semantics(label: 'cx_director_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cx_director_workflow_screen'),
                    child: Column(
                      children: [
                        CxDirectorWorkflowHeaderSection(data: state.data),
                        CxDirectorWorkflowTaskFiltersSection(data: state.data),
                        CxDirectorWorkflowTaskListSection(data: state.data),
                        CxDirectorWorkflowTaskDetailsSection(data: state.data),
                        CxDirectorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
