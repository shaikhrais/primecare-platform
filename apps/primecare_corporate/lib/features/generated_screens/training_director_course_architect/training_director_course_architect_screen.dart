import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_course_architect_header_section.dart';
import 'sections/training_director_course_architect_content_summary_section.dart';
import 'sections/training_director_course_architect_primary_content_section.dart';
import 'sections/training_director_course_architect_action_bar_section.dart';

class TrainingDirectorCourseArchitectScreen extends StatelessWidget {
  const TrainingDirectorCourseArchitectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_course_architect',
      title: 'Training Director Course Architect',
      child: Column(
        children: const [
          const TrainingDirectorCourseArchitectHeaderSection(),
          const TrainingDirectorCourseArchitectContentSummarySection(),
          const TrainingDirectorCourseArchitectPrimaryContentSection(),
          const TrainingDirectorCourseArchitectActionBarSection(),
        ],
      ),
    );
  }
}
