import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_verification_workflow_header_section.dart';
import 'sections/system_verification_workflow_task_filters_section.dart';
import 'sections/system_verification_workflow_task_list_section.dart';
import 'sections/system_verification_workflow_task_details_section.dart';
import 'sections/system_verification_workflow_action_bar_section.dart';

class SystemVerificationWorkflowScreen extends StatelessWidget {
  const SystemVerificationWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_verification_workflow',
      title: 'SystemVerificationWorkflowScreen',
      child: Column(
        children: const [
          const SystemVerificationWorkflowHeaderSection(),
          const SystemVerificationWorkflowTaskFiltersSection(),
          const SystemVerificationWorkflowTaskListSection(),
          const SystemVerificationWorkflowTaskDetailsSection(),
          const SystemVerificationWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
