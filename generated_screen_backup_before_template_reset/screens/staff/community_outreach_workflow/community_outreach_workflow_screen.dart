import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_workflow_header_section.dart';
import 'sections/community_outreach_workflow_task_filters_section.dart';
import 'sections/community_outreach_workflow_task_list_section.dart';
import 'sections/community_outreach_workflow_task_details_section.dart';
import 'sections/community_outreach_workflow_action_bar_section.dart';

class CommunityOutreachWorkflowScreen extends StatelessWidget {
  const CommunityOutreachWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_workflow',
      title: 'CommunityOutreachWorkflowScreen',
      child: Column(
        children: const [
          const CommunityOutreachWorkflowHeaderSection(),
          const CommunityOutreachWorkflowTaskFiltersSection(),
          const CommunityOutreachWorkflowTaskListSection(),
          const CommunityOutreachWorkflowTaskDetailsSection(),
          const CommunityOutreachWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
