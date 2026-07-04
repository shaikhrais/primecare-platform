import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_courses_header_section.dart';
import 'sections/training_coordinator_courses_content_summary_section.dart';
import 'sections/training_coordinator_courses_primary_content_section.dart';
import 'sections/training_coordinator_courses_action_bar_section.dart';

class TrainingCoordinatorCoursesScreen extends StatelessWidget {
  const TrainingCoordinatorCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_courses',
      title: 'Training Coordinator Courses',
      child: Column(
        children: const [
          const TrainingCoordinatorCoursesHeaderSection(),
          const TrainingCoordinatorCoursesContentSummarySection(),
          const TrainingCoordinatorCoursesPrimaryContentSection(),
          const TrainingCoordinatorCoursesActionBarSection(),
        ],
      ),
    );
  }
}
