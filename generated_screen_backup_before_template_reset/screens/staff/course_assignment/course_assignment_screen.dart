import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/course_assignment_header_section.dart';
import 'sections/course_assignment_content_summary_section.dart';
import 'sections/course_assignment_primary_content_section.dart';
import 'sections/course_assignment_action_bar_section.dart';

class CourseAssignmentScreen extends StatelessWidget {
  const CourseAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'course_assignment',
      title: 'CourseAssignmentScreen',
      child: Column(
        children: const [
          const CourseAssignmentHeaderSection(),
          const CourseAssignmentContentSummarySection(),
          const CourseAssignmentPrimaryContentSection(),
          const CourseAssignmentActionBarSection(),
        ],
      ),
    );
  }
}
