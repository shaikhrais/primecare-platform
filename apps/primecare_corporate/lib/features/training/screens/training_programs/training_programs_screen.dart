import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_programs_header_section.dart';
import 'sections/training_programs_content_summary_section.dart';
import 'sections/training_programs_primary_content_section.dart';
import 'sections/training_programs_action_bar_section.dart';

class TrainingProgramsScreen extends StatelessWidget {
  const TrainingProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_programs',
      title: 'Training Programs',
      child: Column(
        children: const [
          const TrainingProgramsHeaderSection(),
          const TrainingProgramsContentSummarySection(),
          const TrainingProgramsPrimaryContentSection(),
          const TrainingProgramsActionBarSection(),
        ],
      ),
    );
  }
}
