import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/course_architect_workflow_header_section.dart';
import 'sections/course_architect_workflow_task_filters_section.dart';
import 'sections/course_architect_workflow_task_list_section.dart';
import 'sections/course_architect_workflow_task_details_section.dart';
import 'sections/course_architect_workflow_action_bar_section.dart';

class CourseArchitectWorkflowScreen extends StatelessWidget {
  const CourseArchitectWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'course_architect_workflow',
      title: 'CourseArchitectWorkflowScreen',
      child: Column(
        children: const [
          const CourseArchitectWorkflowHeaderSection(),
          const CourseArchitectWorkflowTaskFiltersSection(),
          const CourseArchitectWorkflowTaskListSection(),
          const CourseArchitectWorkflowTaskDetailsSection(),
          const CourseArchitectWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
