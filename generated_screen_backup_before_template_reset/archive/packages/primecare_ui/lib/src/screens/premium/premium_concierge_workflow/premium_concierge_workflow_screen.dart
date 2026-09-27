import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/premium_concierge_workflow_header_section.dart';
import 'sections/premium_concierge_workflow_task_filters_section.dart';
import 'sections/premium_concierge_workflow_task_list_section.dart';
import 'sections/premium_concierge_workflow_task_details_section.dart';
import 'sections/premium_concierge_workflow_action_bar_section.dart';

class PremiumConciergeWorkflowScreen extends StatelessWidget {
  const PremiumConciergeWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'premium_concierge_workflow',
      title: 'Premium Concierge Care Coordinator Compliance Workflow',
      child: Column(
        children: const [
          const PremiumConciergeWorkflowHeaderSection(),
          const PremiumConciergeWorkflowTaskFiltersSection(),
          const PremiumConciergeWorkflowTaskListSection(),
          const PremiumConciergeWorkflowTaskDetailsSection(),
          const PremiumConciergeWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
