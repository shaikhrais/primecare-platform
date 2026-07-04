import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/caregiver_tasks_header_section.dart';
import 'sections/caregiver_tasks_task_filters_section.dart';
import 'sections/caregiver_tasks_task_list_section.dart';
import 'sections/caregiver_tasks_task_details_section.dart';
import 'sections/caregiver_tasks_action_bar_section.dart';

class CaregiverTasksScreen extends StatelessWidget {
  const CaregiverTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'caregiver_tasks',
      title: 'CaregiverTasksScreen',
      child: Column(
        children: const [
          const CaregiverTasksHeaderSection(),
          const CaregiverTasksTaskFiltersSection(),
          const CaregiverTasksTaskListSection(),
          const CaregiverTasksTaskDetailsSection(),
          const CaregiverTasksActionBarSection(),
        ],
      ),
    );
  }
}
