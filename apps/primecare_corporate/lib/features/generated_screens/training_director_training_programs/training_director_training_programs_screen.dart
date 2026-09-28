import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_training_programs_header_section.dart';
import 'sections/training_director_training_programs_content_summary_section.dart';
import 'sections/training_director_training_programs_primary_content_section.dart';
import 'sections/training_director_training_programs_action_bar_section.dart';

class TrainingDirectorTrainingProgramsScreen extends StatelessWidget {
  const TrainingDirectorTrainingProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_training_programs',
      title: 'Training Director Training Programs',
      child: Column(
        children: const [
          const TrainingDirectorTrainingProgramsHeaderSection(),
          const TrainingDirectorTrainingProgramsContentSummarySection(),
          const TrainingDirectorTrainingProgramsPrimaryContentSection(),
          const TrainingDirectorTrainingProgramsActionBarSection(),
        ],
      ),
    );
  }
}
