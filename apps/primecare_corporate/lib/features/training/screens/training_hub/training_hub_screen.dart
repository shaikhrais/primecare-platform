import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_hub_header_section.dart';
import 'sections/training_hub_content_summary_section.dart';
import 'sections/training_hub_primary_content_section.dart';
import 'sections/training_hub_action_bar_section.dart';

class TrainingHubScreen extends StatelessWidget {
  const TrainingHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_hub',
      title: 'Training Hub',
      child: Column(
        children: const [
          const TrainingHubHeaderSection(),
          const TrainingHubContentSummarySection(),
          const TrainingHubPrimaryContentSection(),
          const TrainingHubActionBarSection(),
        ],
      ),
    );
  }
}
