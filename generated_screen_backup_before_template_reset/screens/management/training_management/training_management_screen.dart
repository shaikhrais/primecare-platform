import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_management_header_section.dart';
import 'sections/training_management_content_summary_section.dart';
import 'sections/training_management_primary_content_section.dart';
import 'sections/training_management_action_bar_section.dart';

class TrainingManagementScreen extends StatelessWidget {
  const TrainingManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_management',
      title: 'TrainingManagementScreen',
      child: Column(
        children: const [
          const TrainingManagementHeaderSection(),
          const TrainingManagementContentSummarySection(),
          const TrainingManagementPrimaryContentSection(),
          const TrainingManagementActionBarSection(),
        ],
      ),
    );
  }
}
