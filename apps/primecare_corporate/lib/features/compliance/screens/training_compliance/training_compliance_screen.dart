import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_compliance_header_section.dart';
import 'sections/training_compliance_content_summary_section.dart';
import 'sections/training_compliance_primary_content_section.dart';
import 'sections/training_compliance_action_bar_section.dart';

class TrainingComplianceScreen extends StatelessWidget {
  const TrainingComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_compliance',
      title: 'Training Compliance',
      child: Column(
        children: const [
          const TrainingComplianceHeaderSection(),
          const TrainingComplianceContentSummarySection(),
          const TrainingCompliancePrimaryContentSection(),
          const TrainingComplianceActionBarSection(),
        ],
      ),
    );
  }
}
