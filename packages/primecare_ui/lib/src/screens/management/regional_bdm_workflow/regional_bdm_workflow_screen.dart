import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'regional_bdm_workflow_screen_controller.dart';
import 'sections/regional_bdm_workflow_header_section.dart';
import 'sections/regional_bdm_workflow_task_filters_section.dart';
import 'sections/regional_bdm_workflow_task_list_section.dart';
import 'sections/regional_bdm_workflow_task_details_section.dart';
import 'sections/regional_bdm_workflow_action_bar_section.dart';


class RegionalBdmWorkflowScreen extends ConsumerWidget {
  const RegionalBdmWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regional_bdm_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RegionalBdmWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(regional_bdm_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('regional_bdm_workflow_loading'), child: Semantics(label: 'regional_bdm_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('regional_bdm_workflow_screen'),
                    child: Column(
                      children: [
                        RegionalBdmWorkflowHeaderSection(data: state.data),
                        RegionalBdmWorkflowTaskFiltersSection(data: state.data),
                        RegionalBdmWorkflowTaskListSection(data: state.data),
                        RegionalBdmWorkflowTaskDetailsSection(data: state.data),
                        RegionalBdmWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
