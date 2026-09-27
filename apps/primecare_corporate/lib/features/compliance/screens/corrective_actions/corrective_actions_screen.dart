import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/corrective_actions_header_section.dart';
import 'sections/corrective_actions_task_filters_section.dart';
import 'sections/corrective_actions_task_list_section.dart';
import 'sections/corrective_actions_task_details_section.dart';
import 'sections/corrective_actions_action_bar_section.dart';

class CorrectiveActionsScreen extends StatelessWidget {
  const CorrectiveActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'corrective_actions',
      title: 'Corrective Actions',
      child: Column(
        children: const [
          const CorrectiveActionsHeaderSection(),
          const CorrectiveActionsTaskFiltersSection(),
          const CorrectiveActionsTaskListSection(),
          const CorrectiveActionsTaskDetailsSection(),
          const CorrectiveActionsActionBarSection(),
        ],
      ),
    );
  }
}
