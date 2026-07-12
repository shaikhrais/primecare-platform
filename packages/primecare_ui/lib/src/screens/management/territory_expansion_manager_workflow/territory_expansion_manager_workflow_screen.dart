import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'territory_expansion_manager_workflow_screen_controller.dart';
import 'sections/territory_expansion_manager_workflow_header_section.dart';
import 'sections/territory_expansion_manager_workflow_task_filters_section.dart';
import 'sections/territory_expansion_manager_workflow_task_list_section.dart';
import 'sections/territory_expansion_manager_workflow_task_details_section.dart';
import 'sections/territory_expansion_manager_workflow_action_bar_section.dart';


class TerritoryExpansionManagerWorkflowScreen extends ConsumerWidget {
  const TerritoryExpansionManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(territory_expansion_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TerritoryExpansionManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(territory_expansion_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('territory_expansion_manager_workflow_loading'), child: Semantics(label: 'territory_expansion_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('territory_expansion_manager_workflow_screen'),
                    child: Column(
                      children: [
                        TerritoryExpansionManagerWorkflowHeaderSection(data: state.data),
                        TerritoryExpansionManagerWorkflowTaskFiltersSection(data: state.data),
                        TerritoryExpansionManagerWorkflowTaskListSection(data: state.data),
                        TerritoryExpansionManagerWorkflowTaskDetailsSection(data: state.data),
                        TerritoryExpansionManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
