import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_compliance_header_section.dart';
import 'sections/training_director_compliance_content_summary_section.dart';
import 'sections/training_director_compliance_primary_content_section.dart';
import 'sections/training_director_compliance_action_bar_section.dart';

class TrainingDirectorComplianceScreen extends StatelessWidget {
  const TrainingDirectorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_compliance',
      title: 'TrainingDirectorComplianceScreen',
      child: Column(
        children: const [
          const TrainingDirectorComplianceHeaderSection(),
          const TrainingDirectorComplianceContentSummarySection(),
          const TrainingDirectorCompliancePrimaryContentSection(),
          const TrainingDirectorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
