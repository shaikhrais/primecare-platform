import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/course_library_header_section.dart';
import 'sections/course_library_content_summary_section.dart';
import 'sections/course_library_primary_content_section.dart';
import 'sections/course_library_action_bar_section.dart';

class CourseLibraryScreen extends StatelessWidget {
  const CourseLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'course_library',
      title: 'Course Library',
      child: Column(
        children: const [
          const CourseLibraryHeaderSection(),
          const CourseLibraryContentSummarySection(),
          const CourseLibraryPrimaryContentSection(),
          const CourseLibraryActionBarSection(),
        ],
      ),
    );
  }
}
