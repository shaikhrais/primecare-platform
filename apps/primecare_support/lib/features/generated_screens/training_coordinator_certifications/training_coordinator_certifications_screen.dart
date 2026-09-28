import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_certifications_header_section.dart';
import 'sections/training_coordinator_certifications_content_summary_section.dart';
import 'sections/training_coordinator_certifications_primary_content_section.dart';
import 'sections/training_coordinator_certifications_action_bar_section.dart';

class TrainingCoordinatorCertificationsScreen extends StatelessWidget {
  const TrainingCoordinatorCertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_certifications',
      title: 'Training Coordinator Certifications',
      child: Column(
        children: const [
          const TrainingCoordinatorCertificationsHeaderSection(),
          const TrainingCoordinatorCertificationsContentSummarySection(),
          const TrainingCoordinatorCertificationsPrimaryContentSection(),
          const TrainingCoordinatorCertificationsActionBarSection(),
        ],
      ),
    );
  }
}
