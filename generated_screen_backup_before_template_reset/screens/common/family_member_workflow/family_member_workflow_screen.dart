import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_workflow_header_section.dart';
import 'sections/family_member_workflow_task_filters_section.dart';
import 'sections/family_member_workflow_task_list_section.dart';
import 'sections/family_member_workflow_task_details_section.dart';
import 'sections/family_member_workflow_action_bar_section.dart';

class FamilyMemberWorkflowScreen extends StatelessWidget {
  const FamilyMemberWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_workflow',
      title: 'FamilyMemberWorkflowScreen',
      child: Column(
        children: const [
          const FamilyMemberWorkflowHeaderSection(),
          const FamilyMemberWorkflowTaskFiltersSection(),
          const FamilyMemberWorkflowTaskListSection(),
          const FamilyMemberWorkflowTaskDetailsSection(),
          const FamilyMemberWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
