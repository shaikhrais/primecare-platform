import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_hub_compliance_header_section.dart';
import 'sections/training_hub_compliance_content_summary_section.dart';
import 'sections/training_hub_compliance_primary_content_section.dart';
import 'sections/training_hub_compliance_action_bar_section.dart';

class TrainingHubComplianceScreen extends StatelessWidget {
  const TrainingHubComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_hub_compliance',
      title: 'TrainingHubComplianceScreen',
      child: Column(
        children: const [
          const TrainingHubComplianceHeaderSection(),
          const TrainingHubComplianceContentSummarySection(),
          const TrainingHubCompliancePrimaryContentSection(),
          const TrainingHubComplianceActionBarSection(),
        ],
      ),
    );
  }
}
