import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_workshops_header_section.dart';
import 'sections/training_coordinator_workshops_content_summary_section.dart';
import 'sections/training_coordinator_workshops_primary_content_section.dart';
import 'sections/training_coordinator_workshops_action_bar_section.dart';

class TrainingCoordinatorWorkshopsScreen extends StatelessWidget {
  const TrainingCoordinatorWorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_workshops',
      title: 'Training Coordinator Workshops',
      child: Column(
        children: const [
          const TrainingCoordinatorWorkshopsHeaderSection(),
          const TrainingCoordinatorWorkshopsContentSummarySection(),
          const TrainingCoordinatorWorkshopsPrimaryContentSection(),
          const TrainingCoordinatorWorkshopsActionBarSection(),
        ],
      ),
    );
  }
}
