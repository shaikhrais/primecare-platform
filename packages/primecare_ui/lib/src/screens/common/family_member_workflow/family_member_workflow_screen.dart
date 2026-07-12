import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'family_member_workflow_screen_controller.dart';
import 'sections/family_member_workflow_header_section.dart';
import 'sections/family_member_workflow_task_filters_section.dart';
import 'sections/family_member_workflow_task_list_section.dart';
import 'sections/family_member_workflow_task_details_section.dart';
import 'sections/family_member_workflow_action_bar_section.dart';


class FamilyMemberWorkflowScreen extends ConsumerWidget {
  const FamilyMemberWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(family_member_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FamilyMemberWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(family_member_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('family_member_workflow_loading'), child: Semantics(label: 'family_member_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('family_member_workflow_screen'),
                    child: Column(
                      children: [
                        FamilyMemberWorkflowHeaderSection(data: state.data),
                        FamilyMemberWorkflowTaskFiltersSection(data: state.data),
                        FamilyMemberWorkflowTaskListSection(data: state.data),
                        FamilyMemberWorkflowTaskDetailsSection(data: state.data),
                        FamilyMemberWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
