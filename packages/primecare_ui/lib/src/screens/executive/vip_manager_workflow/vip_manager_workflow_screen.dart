import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'vip_manager_workflow_screen_controller.dart';
import 'sections/vip_manager_workflow_header_section.dart';
import 'sections/vip_manager_workflow_task_filters_section.dart';
import 'sections/vip_manager_workflow_task_list_section.dart';
import 'sections/vip_manager_workflow_task_details_section.dart';
import 'sections/vip_manager_workflow_action_bar_section.dart';


class VipClientManagerComplianceWorkflowScreen extends ConsumerWidget {
  const VipClientManagerComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vip_manager_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('VIP Client Manager Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(vip_manager_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('vip_manager_workflow_loading'), child: Semantics(label: 'vip_manager_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('vip_manager_workflow_screen'),
                    child: Column(
                      children: [
                        VipManagerWorkflowHeaderSection(data: state.data),
                        VipManagerWorkflowTaskFiltersSection(data: state.data),
                        VipManagerWorkflowTaskListSection(data: state.data),
                        VipManagerWorkflowTaskDetailsSection(data: state.data),
                        VipManagerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
