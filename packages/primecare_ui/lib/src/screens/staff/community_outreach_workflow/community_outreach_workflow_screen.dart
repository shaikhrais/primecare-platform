import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'community_outreach_workflow_screen_controller.dart';
import 'sections/community_outreach_workflow_header_section.dart';
import 'sections/community_outreach_workflow_task_filters_section.dart';
import 'sections/community_outreach_workflow_task_list_section.dart';
import 'sections/community_outreach_workflow_task_details_section.dart';
import 'sections/community_outreach_workflow_action_bar_section.dart';


class CommunityOutreachWorkflowScreen extends ConsumerWidget {
  const CommunityOutreachWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(community_outreach_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CommunityOutreachWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(community_outreach_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('community_outreach_workflow_loading'), child: Semantics(label: 'community_outreach_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('community_outreach_workflow_screen'),
                    child: Column(
                      children: [
                        CommunityOutreachWorkflowHeaderSection(data: state.data),
                        CommunityOutreachWorkflowTaskFiltersSection(data: state.data),
                        CommunityOutreachWorkflowTaskListSection(data: state.data),
                        CommunityOutreachWorkflowTaskDetailsSection(data: state.data),
                        CommunityOutreachWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
