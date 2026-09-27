import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_workflow_screen_controller.dart';
import 'sections/franchise_workflow_header_section.dart';
import 'sections/franchise_workflow_task_filters_section.dart';
import 'sections/franchise_workflow_task_list_section.dart';
import 'sections/franchise_workflow_task_details_section.dart';
import 'sections/franchise_workflow_action_bar_section.dart';


class FranchiseWorkflowScreen extends ConsumerWidget {
  const FranchiseWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_workflow_loading'), child: Semantics(label: 'franchise_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_workflow_screen'),
                    child: Column(
                      children: [
                        FranchiseWorkflowHeaderSection(data: state.data),
                        FranchiseWorkflowTaskFiltersSection(data: state.data),
                        FranchiseWorkflowTaskListSection(data: state.data),
                        FranchiseWorkflowTaskDetailsSection(data: state.data),
                        FranchiseWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
