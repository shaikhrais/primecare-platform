import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_workflow_header_section.dart';
import 'sections/training_coordinator_workflow_task_filters_section.dart';
import 'sections/training_coordinator_workflow_task_list_section.dart';
import 'sections/training_coordinator_workflow_task_details_section.dart';
import 'sections/training_coordinator_workflow_action_bar_section.dart';

class TrainingCoordinatorWorkflowScreen extends StatelessWidget {
  const TrainingCoordinatorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_workflow',
      title: 'TrainingCoordinatorWorkflowScreen',
      child: Column(
        children: const [
          const TrainingCoordinatorWorkflowHeaderSection(),
          const TrainingCoordinatorWorkflowTaskFiltersSection(),
          const TrainingCoordinatorWorkflowTaskListSection(),
          const TrainingCoordinatorWorkflowTaskDetailsSection(),
          const TrainingCoordinatorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
