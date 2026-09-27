import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_sales_manager_workflow_screen_controller.dart';
import 'sections/franchise_sales_manager_workflow_header_section.dart';
import 'sections/franchise_sales_manager_workflow_task_filters_section.dart';
import 'sections/franchise_sales_manager_workflow_task_list_section.dart';
import 'sections/franchise_sales_manager_workflow_task_details_section.dart';
import 'sections/franchise_sales_manager_workflow_action_bar_section.dart';


class FranchiseSalesManagerWorkflowScreen extends ConsumerWidget {
  const FranchiseSalesManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_sales_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseSalesManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_sales_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_sales_manager_workflow_loading'), child: Semantics(label: 'franchise_sales_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_sales_manager_workflow_screen'),
                    child: Column(
                      children: [
                        FranchiseSalesManagerWorkflowHeaderSection(data: state.data),
                        FranchiseSalesManagerWorkflowTaskFiltersSection(data: state.data),
                        FranchiseSalesManagerWorkflowTaskListSection(data: state.data),
                        FranchiseSalesManagerWorkflowTaskDetailsSection(data: state.data),
                        FranchiseSalesManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
