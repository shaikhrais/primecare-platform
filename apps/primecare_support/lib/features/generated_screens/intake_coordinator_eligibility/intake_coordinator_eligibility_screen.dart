import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_eligibility_header_section.dart';
import 'sections/intake_coordinator_eligibility_content_summary_section.dart';
import 'sections/intake_coordinator_eligibility_primary_content_section.dart';
import 'sections/intake_coordinator_eligibility_action_bar_section.dart';

class IntakeCoordinatorEligibilityScreen extends StatelessWidget {
  const IntakeCoordinatorEligibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_eligibility',
      title: 'Intake Coordinator Eligibility',
      child: Column(
        children: const [
          const IntakeCoordinatorEligibilityHeaderSection(),
          const IntakeCoordinatorEligibilityContentSummarySection(),
          const IntakeCoordinatorEligibilityPrimaryContentSection(),
          const IntakeCoordinatorEligibilityActionBarSection(),
        ],
      ),
    );
  }
}
