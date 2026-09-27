import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_workflow_issues_screen_controller.dart';
import 'sections/coo_workflow_issues_header_section.dart';
import 'sections/coo_workflow_issues_task_filters_section.dart';
import 'sections/coo_workflow_issues_task_list_section.dart';
import 'sections/coo_workflow_issues_task_details_section.dart';
import 'sections/coo_workflow_issues_action_bar_section.dart';


class CooWorkflowIssuesScreen extends ConsumerWidget {
  const CooWorkflowIssuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_workflow_issuesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooWorkflowIssues'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_workflow_issuesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_workflow_issues_loading'), child: Semantics(label: 'coo_workflow_issues_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_workflow_issues_screen'),
                    child: Column(
                      children: [
                        CooWorkflowIssuesHeaderSection(data: state.data),
                        CooWorkflowIssuesTaskFiltersSection(data: state.data),
                        CooWorkflowIssuesTaskListSection(data: state.data),
                        CooWorkflowIssuesTaskDetailsSection(data: state.data),
                        CooWorkflowIssuesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
