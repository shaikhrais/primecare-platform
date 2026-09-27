import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_workflow_screen_controller.dart';
import 'sections/psw_workflow_header_section.dart';
import 'sections/psw_workflow_task_filters_section.dart';
import 'sections/psw_workflow_task_list_section.dart';
import 'sections/psw_workflow_task_details_section.dart';
import 'sections/psw_workflow_action_bar_section.dart';


class PswWorkflowScreen extends ConsumerWidget {
  const PswWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Psw Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_workflow_loading'), child: Semantics(label: 'psw_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_workflow_screen'),
                    child: Column(
                      children: [
                        PswWorkflowHeaderSection(data: state.data),
                        PswWorkflowTaskFiltersSection(data: state.data),
                        PswWorkflowTaskListSection(data: state.data),
                        PswWorkflowTaskDetailsSection(data: state.data),
                        PswWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
