import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/shift_tasks_header_section.dart';
import 'sections/shift_tasks_task_filters_section.dart';
import 'sections/shift_tasks_task_list_section.dart';
import 'sections/shift_tasks_task_details_section.dart';
import 'sections/shift_tasks_action_bar_section.dart';

class ShiftTasksScreen extends StatelessWidget {
  const ShiftTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'shift_tasks',
      title: 'Shift Tasks',
      child: Column(
        children: const [
          const ShiftTasksHeaderSection(),
          const ShiftTasksTaskFiltersSection(),
          const ShiftTasksTaskListSection(),
          const ShiftTasksTaskDetailsSection(),
          const ShiftTasksActionBarSection(),
        ],
      ),
    );
  }
}
