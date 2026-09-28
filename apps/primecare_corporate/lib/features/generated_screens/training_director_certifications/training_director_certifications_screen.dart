import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_certifications_header_section.dart';
import 'sections/training_director_certifications_content_summary_section.dart';
import 'sections/training_director_certifications_primary_content_section.dart';
import 'sections/training_director_certifications_action_bar_section.dart';

class TrainingDirectorCertificationsScreen extends StatelessWidget {
  const TrainingDirectorCertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_certifications',
      title: 'Training Director Certifications',
      child: Column(
        children: const [
          const TrainingDirectorCertificationsHeaderSection(),
          const TrainingDirectorCertificationsContentSummarySection(),
          const TrainingDirectorCertificationsPrimaryContentSection(),
          const TrainingDirectorCertificationsActionBarSection(),
        ],
      ),
    );
  }
}
