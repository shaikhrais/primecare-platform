import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'system_verification_workflow_screen_controller.dart';
import 'sections/system_verification_workflow_header_section.dart';
import 'sections/system_verification_workflow_task_filters_section.dart';
import 'sections/system_verification_workflow_task_list_section.dart';
import 'sections/system_verification_workflow_task_details_section.dart';
import 'sections/system_verification_workflow_action_bar_section.dart';


class SystemVerificationWorkflowScreen extends ConsumerWidget {
  const SystemVerificationWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(system_verification_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SystemVerificationWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(system_verification_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('system_verification_workflow_loading'), child: Semantics(label: 'system_verification_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('system_verification_workflow_screen'),
                    child: Column(
                      children: [
                        SystemVerificationWorkflowHeaderSection(data: state.data),
                        SystemVerificationWorkflowTaskFiltersSection(data: state.data),
                        SystemVerificationWorkflowTaskListSection(data: state.data),
                        SystemVerificationWorkflowTaskDetailsSection(data: state.data),
                        SystemVerificationWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
