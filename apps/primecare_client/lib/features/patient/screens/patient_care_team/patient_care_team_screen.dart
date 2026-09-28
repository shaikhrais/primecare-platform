import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_care_team_header_section.dart';
import 'sections/patient_care_team_content_summary_section.dart';
import 'sections/patient_care_team_primary_content_section.dart';
import 'sections/patient_care_team_action_bar_section.dart';

class PatientCareTeamScreen extends StatelessWidget {
  const PatientCareTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_care_team',
      title: 'Patient Care Team',
      child: Column(
        children: const [
          const PatientCareTeamHeaderSection(),
          const PatientCareTeamContentSummarySection(),
          const PatientCareTeamPrimaryContentSection(),
          const PatientCareTeamActionBarSection(),
        ],
      ),
    );
  }
}
