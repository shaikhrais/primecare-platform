import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'territory_sales_manager_workflow_screen_controller.dart';
import 'sections/territory_sales_manager_workflow_header_section.dart';
import 'sections/territory_sales_manager_workflow_task_filters_section.dart';
import 'sections/territory_sales_manager_workflow_task_list_section.dart';
import 'sections/territory_sales_manager_workflow_task_details_section.dart';
import 'sections/territory_sales_manager_workflow_action_bar_section.dart';


class TerritorySalesManagerWorkflowScreen extends ConsumerWidget {
  const TerritorySalesManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(territory_sales_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TerritorySalesManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(territory_sales_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('territory_sales_manager_workflow_loading'), child: Semantics(label: 'territory_sales_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('territory_sales_manager_workflow_screen'),
                    child: Column(
                      children: [
                        TerritorySalesManagerWorkflowHeaderSection(data: state.data),
                        TerritorySalesManagerWorkflowTaskFiltersSection(data: state.data),
                        TerritorySalesManagerWorkflowTaskListSection(data: state.data),
                        TerritorySalesManagerWorkflowTaskDetailsSection(data: state.data),
                        TerritorySalesManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
