import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_course_library_header_section.dart';
import 'sections/training_director_course_library_content_summary_section.dart';
import 'sections/training_director_course_library_primary_content_section.dart';
import 'sections/training_director_course_library_action_bar_section.dart';

class TrainingDirectorCourseLibraryScreen extends StatelessWidget {
  const TrainingDirectorCourseLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_course_library',
      title: 'Training Director Course Library',
      child: Column(
        children: const [
          const TrainingDirectorCourseLibraryHeaderSection(),
          const TrainingDirectorCourseLibraryContentSummarySection(),
          const TrainingDirectorCourseLibraryPrimaryContentSection(),
          const TrainingDirectorCourseLibraryActionBarSection(),
        ],
      ),
    );
  }
}
