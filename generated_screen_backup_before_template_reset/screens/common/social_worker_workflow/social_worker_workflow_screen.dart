import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/social_worker_workflow_header_section.dart';
import 'sections/social_worker_workflow_task_filters_section.dart';
import 'sections/social_worker_workflow_task_list_section.dart';
import 'sections/social_worker_workflow_task_details_section.dart';
import 'sections/social_worker_workflow_action_bar_section.dart';

class SocialWorkerWorkflowScreen extends StatelessWidget {
  const SocialWorkerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'social_worker_workflow',
      title: 'SocialWorkerWorkflowScreen',
      child: Column(
        children: const [
          const SocialWorkerWorkflowHeaderSection(),
          const SocialWorkerWorkflowTaskFiltersSection(),
          const SocialWorkerWorkflowTaskListSection(),
          const SocialWorkerWorkflowTaskDetailsSection(),
          const SocialWorkerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
