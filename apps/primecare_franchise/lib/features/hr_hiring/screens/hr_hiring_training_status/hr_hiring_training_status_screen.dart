import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_training_status_header_section.dart';
import 'sections/hr_hiring_training_status_content_summary_section.dart';
import 'sections/hr_hiring_training_status_primary_content_section.dart';
import 'sections/hr_hiring_training_status_action_bar_section.dart';

class HrHiringTrainingStatusScreen extends StatelessWidget {
  const HrHiringTrainingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_training_status',
      title: 'Hr Hiring Training Status',
      child: Column(
        children: const [
          const HrHiringTrainingStatusHeaderSection(),
          const HrHiringTrainingStatusContentSummarySection(),
          const HrHiringTrainingStatusPrimaryContentSection(),
          const HrHiringTrainingStatusActionBarSection(),
        ],
      ),
    );
  }
}
