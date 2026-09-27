import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_care_plan_header_section.dart';
import 'sections/patient_care_plan_content_summary_section.dart';
import 'sections/patient_care_plan_primary_content_section.dart';
import 'sections/patient_care_plan_action_bar_section.dart';

class PatientCarePlanScreen extends StatelessWidget {
  const PatientCarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_care_plan',
      title: 'PatientCarePlanScreen',
      child: Column(
        children: const [
          const PatientCarePlanHeaderSection(),
          const PatientCarePlanContentSummarySection(),
          const PatientCarePlanPrimaryContentSection(),
          const PatientCarePlanActionBarSection(),
        ],
      ),
    );
  }
}
