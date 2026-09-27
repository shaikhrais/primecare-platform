import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_workflow_header_section.dart';
import 'sections/chiropractor_workflow_task_filters_section.dart';
import 'sections/chiropractor_workflow_task_list_section.dart';
import 'sections/chiropractor_workflow_task_details_section.dart';
import 'sections/chiropractor_workflow_action_bar_section.dart';

class ChiropractorWorkflowScreen extends StatelessWidget {
  const ChiropractorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_workflow',
      title: 'ChiropractorWorkflowScreen',
      child: Column(
        children: const [
          const ChiropractorWorkflowHeaderSection(),
          const ChiropractorWorkflowTaskFiltersSection(),
          const ChiropractorWorkflowTaskListSection(),
          const ChiropractorWorkflowTaskDetailsSection(),
          const ChiropractorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
