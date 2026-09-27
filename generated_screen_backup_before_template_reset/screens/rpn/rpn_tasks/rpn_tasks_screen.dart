import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_tasks_header_section.dart';
import 'sections/rpn_tasks_task_filters_section.dart';
import 'sections/rpn_tasks_task_list_section.dart';
import 'sections/rpn_tasks_task_details_section.dart';
import 'sections/rpn_tasks_action_bar_section.dart';

class RpnTasksScreen extends StatelessWidget {
  const RpnTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_tasks',
      title: 'RpnTasksScreen',
      child: Column(
        children: const [
          const RpnTasksHeaderSection(),
          const RpnTasksTaskFiltersSection(),
          const RpnTasksTaskListSection(),
          const RpnTasksTaskDetailsSection(),
          const RpnTasksActionBarSection(),
        ],
      ),
    );
  }
}
