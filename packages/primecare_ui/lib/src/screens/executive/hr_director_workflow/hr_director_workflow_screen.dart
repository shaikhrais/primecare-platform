import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_director_workflow_screen_controller.dart';
import 'sections/hr_director_workflow_header_section.dart';
import 'sections/hr_director_workflow_task_filters_section.dart';
import 'sections/hr_director_workflow_task_list_section.dart';
import 'sections/hr_director_workflow_task_details_section.dart';
import 'sections/hr_director_workflow_action_bar_section.dart';


class HrDirectorWorkflowScreen extends ConsumerWidget {
  const HrDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_director_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrDirectorWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_director_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_director_workflow_loading'), child: Semantics(label: 'hr_director_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_director_workflow_screen'),
                    child: Column(
                      children: [
                        HrDirectorWorkflowHeaderSection(data: state.data),
                        HrDirectorWorkflowTaskFiltersSection(data: state.data),
                        HrDirectorWorkflowTaskListSection(data: state.data),
                        HrDirectorWorkflowTaskDetailsSection(data: state.data),
                        HrDirectorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
