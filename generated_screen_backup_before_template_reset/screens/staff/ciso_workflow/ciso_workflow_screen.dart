import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ciso_workflow_header_section.dart';
import 'sections/ciso_workflow_task_filters_section.dart';
import 'sections/ciso_workflow_task_list_section.dart';
import 'sections/ciso_workflow_task_details_section.dart';
import 'sections/ciso_workflow_action_bar_section.dart';

class CisoWorkflowScreen extends StatelessWidget {
  const CisoWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ciso_workflow',
      title: 'CisoWorkflowScreen',
      child: Column(
        children: const [
          const CisoWorkflowHeaderSection(),
          const CisoWorkflowTaskFiltersSection(),
          const CisoWorkflowTaskListSection(),
          const CisoWorkflowTaskDetailsSection(),
          const CisoWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
