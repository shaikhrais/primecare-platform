import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/corrective_action_header_section.dart';
import 'sections/corrective_action_task_filters_section.dart';
import 'sections/corrective_action_task_list_section.dart';
import 'sections/corrective_action_task_details_section.dart';
import 'sections/corrective_action_action_bar_section.dart';

class CorrectiveActionScreen extends StatelessWidget {
  const CorrectiveActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'corrective_action',
      title: 'CorrectiveActionScreen',
      child: Column(
        children: const [
          const CorrectiveActionHeaderSection(),
          const CorrectiveActionTaskFiltersSection(),
          const CorrectiveActionTaskListSection(),
          const CorrectiveActionTaskDetailsSection(),
          const CorrectiveActionActionBarSection(),
        ],
      ),
    );
  }
}
