import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_progress_header_section.dart';
import 'sections/training_coordinator_progress_content_summary_section.dart';
import 'sections/training_coordinator_progress_primary_content_section.dart';
import 'sections/training_coordinator_progress_action_bar_section.dart';

class TrainingCoordinatorProgressScreen extends StatelessWidget {
  const TrainingCoordinatorProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_progress',
      title: 'Training Coordinator Progress',
      child: Column(
        children: const [
          const TrainingCoordinatorProgressHeaderSection(),
          const TrainingCoordinatorProgressContentSummarySection(),
          const TrainingCoordinatorProgressPrimaryContentSection(),
          const TrainingCoordinatorProgressActionBarSection(),
        ],
      ),
    );
  }
}
