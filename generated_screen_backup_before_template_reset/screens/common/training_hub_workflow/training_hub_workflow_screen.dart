import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_hub_workflow_header_section.dart';
import 'sections/training_hub_workflow_task_filters_section.dart';
import 'sections/training_hub_workflow_task_list_section.dart';
import 'sections/training_hub_workflow_task_details_section.dart';
import 'sections/training_hub_workflow_action_bar_section.dart';

class TrainingHubWorkflowScreen extends StatelessWidget {
  const TrainingHubWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_hub_workflow',
      title: 'TrainingHubWorkflowScreen',
      child: Column(
        children: const [
          const TrainingHubWorkflowHeaderSection(),
          const TrainingHubWorkflowTaskFiltersSection(),
          const TrainingHubWorkflowTaskListSection(),
          const TrainingHubWorkflowTaskDetailsSection(),
          const TrainingHubWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
