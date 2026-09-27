import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_workflow_screen_controller.dart';
import 'sections/coo_workflow_header_section.dart';
import 'sections/coo_workflow_task_filters_section.dart';
import 'sections/coo_workflow_task_list_section.dart';
import 'sections/coo_workflow_task_details_section.dart';
import 'sections/coo_workflow_action_bar_section.dart';


class CooWorkflowScreen extends ConsumerWidget {
  const CooWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_workflow_loading'), child: Semantics(label: 'coo_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_workflow_screen'),
                    child: Column(
                      children: [
                        CooWorkflowHeaderSection(data: state.data),
                        CooWorkflowTaskFiltersSection(data: state.data),
                        CooWorkflowTaskListSection(data: state.data),
                        CooWorkflowTaskDetailsSection(data: state.data),
                        CooWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
