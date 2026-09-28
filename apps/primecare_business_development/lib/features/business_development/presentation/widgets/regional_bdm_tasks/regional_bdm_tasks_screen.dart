import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_tasks_header_section.dart';
import 'sections/regional_bdm_tasks_task_filters_section.dart';
import 'sections/regional_bdm_tasks_task_list_section.dart';
import 'sections/regional_bdm_tasks_task_details_section.dart';
import 'sections/regional_bdm_tasks_action_bar_section.dart';

class RegionalBdmTasksScreen extends StatelessWidget {
  const RegionalBdmTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_tasks',
      title: 'Regional Bdm Tasks',
      child: Column(
        children: const [
          const RegionalBdmTasksHeaderSection(),
          const RegionalBdmTasksTaskFiltersSection(),
          const RegionalBdmTasksTaskListSection(),
          const RegionalBdmTasksTaskDetailsSection(),
          const RegionalBdmTasksActionBarSection(),
        ],
      ),
    );
  }
}
