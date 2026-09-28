import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_hub_header_section.dart';
import 'sections/training_director_hub_content_summary_section.dart';
import 'sections/training_director_hub_primary_content_section.dart';
import 'sections/training_director_hub_action_bar_section.dart';

class TrainingDirectorHubScreen extends StatelessWidget {
  const TrainingDirectorHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_hub',
      title: 'Training Director Hub',
      child: Column(
        children: const [
          const TrainingDirectorHubHeaderSection(),
          const TrainingDirectorHubContentSummarySection(),
          const TrainingDirectorHubPrimaryContentSection(),
          const TrainingDirectorHubActionBarSection(),
        ],
      ),
    );
  }
}
