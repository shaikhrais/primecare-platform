import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'finance_director_workflow_screen_controller.dart';
import 'sections/finance_director_workflow_header_section.dart';
import 'sections/finance_director_workflow_task_filters_section.dart';
import 'sections/finance_director_workflow_task_list_section.dart';
import 'sections/finance_director_workflow_task_details_section.dart';
import 'sections/finance_director_workflow_action_bar_section.dart';


class FinanceDirectorWorkflowScreen extends ConsumerWidget {
  const FinanceDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(finance_director_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FinanceDirectorWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(finance_director_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('finance_director_workflow_loading'), child: Semantics(label: 'finance_director_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('finance_director_workflow_screen'),
                    child: Column(
                      children: [
                        FinanceDirectorWorkflowHeaderSection(data: state.data),
                        FinanceDirectorWorkflowTaskFiltersSection(data: state.data),
                        FinanceDirectorWorkflowTaskListSection(data: state.data),
                        FinanceDirectorWorkflowTaskDetailsSection(data: state.data),
                        FinanceDirectorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
