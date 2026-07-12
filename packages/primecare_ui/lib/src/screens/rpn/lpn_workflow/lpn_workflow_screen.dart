import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'lpn_workflow_screen_controller.dart';
import 'sections/lpn_workflow_header_section.dart';
import 'sections/lpn_workflow_task_filters_section.dart';
import 'sections/lpn_workflow_task_list_section.dart';
import 'sections/lpn_workflow_task_details_section.dart';
import 'sections/lpn_workflow_action_bar_section.dart';


class LicensedPracticalNurseLpnComplianceWorkflowScreen extends ConsumerWidget {
  const LicensedPracticalNurseLpnComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lpn_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Licensed Practical Nurse (LPN) Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(lpn_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('lpn_workflow_loading'), child: Semantics(label: 'lpn_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('lpn_workflow_screen'),
                    child: Column(
                      children: [
                        LpnWorkflowHeaderSection(data: state.data),
                        LpnWorkflowTaskFiltersSection(data: state.data),
                        LpnWorkflowTaskListSection(data: state.data),
                        LpnWorkflowTaskDetailsSection(data: state.data),
                        LpnWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef LicensedPracticalNurseLPNComplianceWorkflowScreen = LicensedPracticalNurseLpnComplianceWorkflowScreen;
