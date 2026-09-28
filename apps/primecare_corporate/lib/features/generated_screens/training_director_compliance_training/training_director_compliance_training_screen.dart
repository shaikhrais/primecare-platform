import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_compliance_training_header_section.dart';
import 'sections/training_director_compliance_training_content_summary_section.dart';
import 'sections/training_director_compliance_training_primary_content_section.dart';
import 'sections/training_director_compliance_training_action_bar_section.dart';

class TrainingDirectorComplianceTrainingScreen extends StatelessWidget {
  const TrainingDirectorComplianceTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_compliance_training',
      title: 'Training Director Compliance Training',
      child: Column(
        children: const [
          const TrainingDirectorComplianceTrainingHeaderSection(),
          const TrainingDirectorComplianceTrainingContentSummarySection(),
          const TrainingDirectorComplianceTrainingPrimaryContentSection(),
          const TrainingDirectorComplianceTrainingActionBarSection(),
        ],
      ),
    );
  }
}
