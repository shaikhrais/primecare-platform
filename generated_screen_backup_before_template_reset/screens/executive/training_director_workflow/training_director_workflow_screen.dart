import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_workflow_header_section.dart';
import 'sections/training_director_workflow_task_filters_section.dart';
import 'sections/training_director_workflow_task_list_section.dart';
import 'sections/training_director_workflow_task_details_section.dart';
import 'sections/training_director_workflow_action_bar_section.dart';

class TrainingDirectorWorkflowScreen extends StatelessWidget {
  const TrainingDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_workflow',
      title: 'TrainingDirectorWorkflowScreen',
      child: Column(
        children: const [
          const TrainingDirectorWorkflowHeaderSection(),
          const TrainingDirectorWorkflowTaskFiltersSection(),
          const TrainingDirectorWorkflowTaskListSection(),
          const TrainingDirectorWorkflowTaskDetailsSection(),
          const TrainingDirectorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
