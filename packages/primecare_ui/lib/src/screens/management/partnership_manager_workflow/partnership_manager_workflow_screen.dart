import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'partnership_manager_workflow_screen_controller.dart';
import 'sections/partnership_manager_workflow_header_section.dart';
import 'sections/partnership_manager_workflow_task_filters_section.dart';
import 'sections/partnership_manager_workflow_task_list_section.dart';
import 'sections/partnership_manager_workflow_task_details_section.dart';
import 'sections/partnership_manager_workflow_action_bar_section.dart';


class PartnershipManagerWorkflowScreen extends ConsumerWidget {
  const PartnershipManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnership_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PartnershipManagerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(partnership_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('partnership_manager_workflow_loading'), child: Semantics(label: 'partnership_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('partnership_manager_workflow_screen'),
                    child: Column(
                      children: [
                        PartnershipManagerWorkflowHeaderSection(data: state.data),
                        PartnershipManagerWorkflowTaskFiltersSection(data: state.data),
                        PartnershipManagerWorkflowTaskListSection(data: state.data),
                        PartnershipManagerWorkflowTaskDetailsSection(data: state.data),
                        PartnershipManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
