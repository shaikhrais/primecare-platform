import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/nursing_task_header_section.dart';
import 'sections/nursing_task_task_filters_section.dart';
import 'sections/nursing_task_task_list_section.dart';
import 'sections/nursing_task_task_details_section.dart';
import 'sections/nursing_task_action_bar_section.dart';

class NursingTaskScreen extends StatelessWidget {
  const NursingTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'nursing_task',
      title: 'NursingTaskScreen',
      child: Column(
        children: const [
          const NursingTaskHeaderSection(),
          const NursingTaskTaskFiltersSection(),
          const NursingTaskTaskListSection(),
          const NursingTaskTaskDetailsSection(),
          const NursingTaskActionBarSection(),
        ],
      ),
    );
  }
}
