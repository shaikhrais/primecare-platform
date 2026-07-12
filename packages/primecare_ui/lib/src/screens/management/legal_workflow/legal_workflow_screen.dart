import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'legal_workflow_screen_controller.dart';
import 'sections/legal_workflow_header_section.dart';
import 'sections/legal_workflow_task_filters_section.dart';
import 'sections/legal_workflow_task_list_section.dart';
import 'sections/legal_workflow_task_details_section.dart';
import 'sections/legal_workflow_action_bar_section.dart';


class LegalWorkflowScreen extends ConsumerWidget {
  const LegalWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(legal_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LegalWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(legal_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('legal_workflow_loading'), child: Semantics(label: 'legal_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('legal_workflow_screen'),
                    child: Column(
                      children: [
                        LegalWorkflowHeaderSection(data: state.data),
                        LegalWorkflowTaskFiltersSection(data: state.data),
                        LegalWorkflowTaskListSection(data: state.data),
                        LegalWorkflowTaskDetailsSection(data: state.data),
                        LegalWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
