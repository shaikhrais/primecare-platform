import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'regional_manager_usa_workflow_screen_controller.dart';
import 'sections/regional_manager_usa_workflow_header_section.dart';
import 'sections/regional_manager_usa_workflow_task_filters_section.dart';
import 'sections/regional_manager_usa_workflow_task_list_section.dart';
import 'sections/regional_manager_usa_workflow_task_details_section.dart';
import 'sections/regional_manager_usa_workflow_action_bar_section.dart';


class RegionalManagerUsaWorkflowScreen extends ConsumerWidget {
  const RegionalManagerUsaWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regional_manager_usa_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RegionalManagerUsaWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(regional_manager_usa_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('regional_manager_usa_workflow_loading'), child: Semantics(label: 'regional_manager_usa_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('regional_manager_usa_workflow_screen'),
                    child: Column(
                      children: [
                        RegionalManagerUsaWorkflowHeaderSection(data: state.data),
                        RegionalManagerUsaWorkflowTaskFiltersSection(data: state.data),
                        RegionalManagerUsaWorkflowTaskListSection(data: state.data),
                        RegionalManagerUsaWorkflowTaskDetailsSection(data: state.data),
                        RegionalManagerUsaWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
