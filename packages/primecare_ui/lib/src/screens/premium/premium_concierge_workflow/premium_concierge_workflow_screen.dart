import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'premium_concierge_workflow_screen_controller.dart';
import 'sections/premium_concierge_workflow_header_section.dart';
import 'sections/premium_concierge_workflow_task_filters_section.dart';
import 'sections/premium_concierge_workflow_task_list_section.dart';
import 'sections/premium_concierge_workflow_task_details_section.dart';
import 'sections/premium_concierge_workflow_action_bar_section.dart';


class PremiumConciergeCareCoordinatorComplianceWorkflowScreen extends ConsumerWidget {
  const PremiumConciergeCareCoordinatorComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(premium_concierge_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Premium Concierge Care Coordinator Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(premium_concierge_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('premium_concierge_workflow_loading'), child: Semantics(label: 'premium_concierge_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('premium_concierge_workflow_screen'),
                    child: Column(
                      children: [
                        PremiumConciergeWorkflowHeaderSection(data: state.data),
                        PremiumConciergeWorkflowTaskFiltersSection(data: state.data),
                        PremiumConciergeWorkflowTaskListSection(data: state.data),
                        PremiumConciergeWorkflowTaskDetailsSection(data: state.data),
                        PremiumConciergeWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
