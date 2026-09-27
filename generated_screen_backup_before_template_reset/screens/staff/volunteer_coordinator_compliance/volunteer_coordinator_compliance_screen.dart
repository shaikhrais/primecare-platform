import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/volunteer_coordinator_compliance_header_section.dart';
import 'sections/volunteer_coordinator_compliance_content_summary_section.dart';
import 'sections/volunteer_coordinator_compliance_primary_content_section.dart';
import 'sections/volunteer_coordinator_compliance_action_bar_section.dart';

class VolunteerCoordinatorComplianceScreen extends StatelessWidget {
  const VolunteerCoordinatorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'volunteer_coordinator_compliance',
      title: 'VolunteerCoordinatorComplianceScreen',
      child: Column(
        children: const [
          const VolunteerCoordinatorComplianceHeaderSection(),
          const VolunteerCoordinatorComplianceContentSummarySection(),
          const VolunteerCoordinatorCompliancePrimaryContentSection(),
          const VolunteerCoordinatorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
