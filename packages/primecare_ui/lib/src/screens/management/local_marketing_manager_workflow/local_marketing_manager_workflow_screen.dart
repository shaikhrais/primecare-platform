import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'local_marketing_manager_workflow_screen_controller.dart';
import 'sections/local_marketing_manager_workflow_header_section.dart';
import 'sections/local_marketing_manager_workflow_task_filters_section.dart';
import 'sections/local_marketing_manager_workflow_task_list_section.dart';
import 'sections/local_marketing_manager_workflow_task_details_section.dart';
import 'sections/local_marketing_manager_workflow_action_bar_section.dart';


class LocalMarketingManagerWorkflowScreen extends ConsumerWidget {
  const LocalMarketingManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(local_marketing_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LocalMarketingManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(local_marketing_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('local_marketing_manager_workflow_loading'), child: Semantics(label: 'local_marketing_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('local_marketing_manager_workflow_screen'),
                    child: Column(
                      children: [
                        LocalMarketingManagerWorkflowHeaderSection(data: state.data),
                        LocalMarketingManagerWorkflowTaskFiltersSection(data: state.data),
                        LocalMarketingManagerWorkflowTaskListSection(data: state.data),
                        LocalMarketingManagerWorkflowTaskDetailsSection(data: state.data),
                        LocalMarketingManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
