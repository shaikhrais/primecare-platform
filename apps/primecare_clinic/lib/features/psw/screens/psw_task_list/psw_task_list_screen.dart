import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_task_list_header_section.dart';
import 'sections/psw_task_list_task_filters_section.dart';
import 'sections/psw_task_list_task_list_section.dart';
import 'sections/psw_task_list_task_details_section.dart';
import 'sections/psw_task_list_action_bar_section.dart';

class PswTaskListScreen extends StatelessWidget {
  const PswTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_task_list',
      title: 'Psw Task List',
      child: Column(
        children: const [
          const PswTaskListHeaderSection(),
          const PswTaskListTaskFiltersSection(),
          const PswTaskListTaskListSection(),
          const PswTaskListTaskDetailsSection(),
          const PswTaskListActionBarSection(),
        ],
      ),
    );
  }
}
