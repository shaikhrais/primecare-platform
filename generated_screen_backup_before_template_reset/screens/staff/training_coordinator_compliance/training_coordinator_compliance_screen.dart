import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_compliance_header_section.dart';
import 'sections/training_coordinator_compliance_content_summary_section.dart';
import 'sections/training_coordinator_compliance_primary_content_section.dart';
import 'sections/training_coordinator_compliance_action_bar_section.dart';

class TrainingCoordinatorComplianceScreen extends StatelessWidget {
  const TrainingCoordinatorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_compliance',
      title: 'TrainingCoordinatorComplianceScreen',
      child: Column(
        children: const [
          const TrainingCoordinatorComplianceHeaderSection(),
          const TrainingCoordinatorComplianceContentSummarySection(),
          const TrainingCoordinatorCompliancePrimaryContentSection(),
          const TrainingCoordinatorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
