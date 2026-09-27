import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_compliance_header_section.dart';
import 'sections/intake_coordinator_compliance_content_summary_section.dart';
import 'sections/intake_coordinator_compliance_primary_content_section.dart';
import 'sections/intake_coordinator_compliance_action_bar_section.dart';

class IntakeCoordinatorComplianceScreen extends StatelessWidget {
  const IntakeCoordinatorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_compliance',
      title: 'IntakeCoordinatorComplianceScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorComplianceHeaderSection(),
          const IntakeCoordinatorComplianceContentSummarySection(),
          const IntakeCoordinatorCompliancePrimaryContentSection(),
          const IntakeCoordinatorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
