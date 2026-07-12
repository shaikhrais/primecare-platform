import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'workflow_issue_screen_controller.dart';
import 'sections/workflow_issue_header_section.dart';
import 'sections/workflow_issue_task_filters_section.dart';
import 'sections/workflow_issue_task_list_section.dart';
import 'sections/workflow_issue_task_details_section.dart';
import 'sections/workflow_issue_action_bar_section.dart';


class WorkflowIssueScreen extends ConsumerWidget {
  const WorkflowIssueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workflow_issueControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('WorkflowIssue'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(workflow_issueControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('workflow_issue_loading'), child: Semantics(label: 'workflow_issue_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('workflow_issue_screen'),
                    child: Column(
                      children: [
                        WorkflowIssueHeaderSection(data: state.data),
                        WorkflowIssueTaskFiltersSection(data: state.data),
                        WorkflowIssueTaskListSection(data: state.data),
                        WorkflowIssueTaskDetailsSection(data: state.data),
                        WorkflowIssueActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
