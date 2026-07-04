import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_observation_header_section.dart';
import 'sections/patient_observation_content_summary_section.dart';
import 'sections/patient_observation_primary_content_section.dart';
import 'sections/patient_observation_action_bar_section.dart';

class PatientObservationScreen extends StatelessWidget {
  const PatientObservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_observation',
      title: 'PatientObservationScreen',
      child: Column(
        children: const [
          const PatientObservationHeaderSection(),
          const PatientObservationContentSummarySection(),
          const PatientObservationPrimaryContentSection(),
          const PatientObservationActionBarSection(),
        ],
      ),
    );
  }
}
