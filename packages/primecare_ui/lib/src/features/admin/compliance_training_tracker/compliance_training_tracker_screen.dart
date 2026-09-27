import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_training_tracker_header_section.dart';
import 'sections/compliance_training_tracker_content_summary_section.dart';
import 'sections/compliance_training_tracker_primary_content_section.dart';
import 'sections/compliance_training_tracker_action_bar_section.dart';

class ComplianceTrainingTrackerScreen extends StatelessWidget {
  const ComplianceTrainingTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_training_tracker',
      title: 'Compliance Training Tracker',
      child: Column(
        children: const [
          const ComplianceTrainingTrackerHeaderSection(),
          const ComplianceTrainingTrackerContentSummarySection(),
          const ComplianceTrainingTrackerPrimaryContentSection(),
          const ComplianceTrainingTrackerActionBarSection(),
        ],
      ),
    );
  }
}
