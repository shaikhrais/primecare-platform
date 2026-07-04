import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_trainer_assignments_header_section.dart';
import 'sections/training_director_trainer_assignments_content_summary_section.dart';
import 'sections/training_director_trainer_assignments_primary_content_section.dart';
import 'sections/training_director_trainer_assignments_action_bar_section.dart';

class TrainingDirectorTrainerAssignmentsScreen extends StatelessWidget {
  const TrainingDirectorTrainerAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_trainer_assignments',
      title: 'Training Director Trainer Assignments',
      child: Column(
        children: const [
          const TrainingDirectorTrainerAssignmentsHeaderSection(),
          const TrainingDirectorTrainerAssignmentsContentSummarySection(),
          const TrainingDirectorTrainerAssignmentsPrimaryContentSection(),
          const TrainingDirectorTrainerAssignmentsActionBarSection(),
        ],
      ),
    );
  }
}
