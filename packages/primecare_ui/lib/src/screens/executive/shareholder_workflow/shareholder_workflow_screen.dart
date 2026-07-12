import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'shareholder_workflow_screen_controller.dart';
import 'sections/shareholder_workflow_header_section.dart';
import 'sections/shareholder_workflow_task_filters_section.dart';
import 'sections/shareholder_workflow_task_list_section.dart';
import 'sections/shareholder_workflow_task_details_section.dart';
import 'sections/shareholder_workflow_action_bar_section.dart';


class ShareholderWorkflowScreen extends ConsumerWidget {
  const ShareholderWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shareholder_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ShareholderWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(shareholder_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('shareholder_workflow_loading'), child: Semantics(label: 'shareholder_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('shareholder_workflow_screen'),
                    child: Column(
                      children: [
                        ShareholderWorkflowHeaderSection(data: state.data),
                        ShareholderWorkflowTaskFiltersSection(data: state.data),
                        ShareholderWorkflowTaskListSection(data: state.data),
                        ShareholderWorkflowTaskDetailsSection(data: state.data),
                        ShareholderWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
