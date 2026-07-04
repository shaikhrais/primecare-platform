import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_trial_outcomeser_header_section.dart';
import 'sections/patient_trial_outcomeser_content_summary_section.dart';
import 'sections/patient_trial_outcomeser_primary_content_section.dart';
import 'sections/patient_trial_outcomeser_action_bar_section.dart';

class PatientTrialOutcomeserScreen extends StatelessWidget {
  const PatientTrialOutcomeserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_trial_outcomeser',
      title: 'Patient Trial Outcomeser',
      child: Column(
        children: const [
          const PatientTrialOutcomeserHeaderSection(),
          const PatientTrialOutcomeserContentSummarySection(),
          const PatientTrialOutcomeserPrimaryContentSection(),
          const PatientTrialOutcomeserActionBarSection(),
        ],
      ),
    );
  }
}
