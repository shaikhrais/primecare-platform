import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_workflow_performance_header_section.dart';
import 'sections/coo_workflow_performance_form_body_section.dart';
import 'sections/coo_workflow_performance_validation_messages_section.dart';
import 'sections/coo_workflow_performance_action_bar_section.dart';

class CooWorkflowPerformanceScreen extends StatelessWidget {
  const CooWorkflowPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_workflow_performance',
      title: 'Coo Workflow Performance',
      child: Column(
        children: const [
          const CooWorkflowPerformanceHeaderSection(),
          const CooWorkflowPerformanceFormBodySection(),
          const CooWorkflowPerformanceValidationMessagesSection(),
          const CooWorkflowPerformanceActionBarSection(),
        ],
      ),
    );
  }
}
