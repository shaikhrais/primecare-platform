import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'social_worker_workflow_screen_controller.dart';
import 'sections/social_worker_workflow_header_section.dart';
import 'sections/social_worker_workflow_task_filters_section.dart';
import 'sections/social_worker_workflow_task_list_section.dart';
import 'sections/social_worker_workflow_task_details_section.dart';
import 'sections/social_worker_workflow_action_bar_section.dart';


class SocialWorkerWorkflowScreen extends ConsumerWidget {
  const SocialWorkerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(social_worker_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SocialWorkerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(social_worker_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('social_worker_workflow_loading'), child: Semantics(label: 'social_worker_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('social_worker_workflow_screen'),
                    child: Column(
                      children: [
                        SocialWorkerWorkflowHeaderSection(data: state.data),
                        SocialWorkerWorkflowTaskFiltersSection(data: state.data),
                        SocialWorkerWorkflowTaskListSection(data: state.data),
                        SocialWorkerWorkflowTaskDetailsSection(data: state.data),
                        SocialWorkerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
