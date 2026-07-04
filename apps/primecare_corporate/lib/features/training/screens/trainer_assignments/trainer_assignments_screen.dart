import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/trainer_assignments_header_section.dart';
import 'sections/trainer_assignments_content_summary_section.dart';
import 'sections/trainer_assignments_primary_content_section.dart';
import 'sections/trainer_assignments_action_bar_section.dart';

class TrainerAssignmentsScreen extends StatelessWidget {
  const TrainerAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'trainer_assignments',
      title: 'Trainer Assignments',
      child: Column(
        children: const [
          const TrainerAssignmentsHeaderSection(),
          const TrainerAssignmentsContentSummarySection(),
          const TrainerAssignmentsPrimaryContentSection(),
          const TrainerAssignmentsActionBarSection(),
        ],
      ),
    );
  }
}
