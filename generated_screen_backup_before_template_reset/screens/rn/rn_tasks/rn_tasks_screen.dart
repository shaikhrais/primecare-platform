import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_tasks_header_section.dart';
import 'sections/rn_tasks_task_filters_section.dart';
import 'sections/rn_tasks_task_list_section.dart';
import 'sections/rn_tasks_task_details_section.dart';
import 'sections/rn_tasks_action_bar_section.dart';

class RnTasksScreen extends StatelessWidget {
  const RnTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_tasks',
      title: 'RnTasksScreen',
      child: Column(
        children: const [
          const RnTasksHeaderSection(),
          const RnTasksTaskFiltersSection(),
          const RnTasksTaskListSection(),
          const RnTasksTaskDetailsSection(),
          const RnTasksActionBarSection(),
        ],
      ),
    );
  }
}
