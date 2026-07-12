import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'head_of_marketing_workflow_screen_controller.dart';
import 'sections/head_of_marketing_workflow_header_section.dart';
import 'sections/head_of_marketing_workflow_task_filters_section.dart';
import 'sections/head_of_marketing_workflow_task_list_section.dart';
import 'sections/head_of_marketing_workflow_task_details_section.dart';
import 'sections/head_of_marketing_workflow_action_bar_section.dart';


class HeadOfMarketingWorkflowScreen extends ConsumerWidget {
  const HeadOfMarketingWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(head_of_marketing_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HeadOfMarketingWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(head_of_marketing_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('head_of_marketing_workflow_loading'), child: Semantics(label: 'head_of_marketing_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('head_of_marketing_workflow_screen'),
                    child: Column(
                      children: [
                        HeadOfMarketingWorkflowHeaderSection(data: state.data),
                        HeadOfMarketingWorkflowTaskFiltersSection(data: state.data),
                        HeadOfMarketingWorkflowTaskListSection(data: state.data),
                        HeadOfMarketingWorkflowTaskDetailsSection(data: state.data),
                        HeadOfMarketingWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
