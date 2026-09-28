import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/course_architect_header_section.dart';
import 'sections/course_architect_content_summary_section.dart';
import 'sections/course_architect_primary_content_section.dart';
import 'sections/course_architect_action_bar_section.dart';

class CourseArchitectScreen extends StatelessWidget {
  const CourseArchitectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'course_architect',
      title: 'Course Architect',
      child: Column(
        children: const [
          const CourseArchitectHeaderSection(),
          const CourseArchitectContentSummarySection(),
          const CourseArchitectPrimaryContentSection(),
          const CourseArchitectActionBarSection(),
        ],
      ),
    );
  }
}
