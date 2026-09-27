import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_medication_adherence_header_section.dart';
import 'sections/patient_medication_adherence_content_summary_section.dart';
import 'sections/patient_medication_adherence_primary_content_section.dart';
import 'sections/patient_medication_adherence_action_bar_section.dart';

class PatientMedicationAdherenceScreen extends StatelessWidget {
  const PatientMedicationAdherenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_medication_adherence',
      title: 'Patient Medication Adherence',
      child: Column(
        children: const [
          const PatientMedicationAdherenceHeaderSection(),
          const PatientMedicationAdherenceContentSummarySection(),
          const PatientMedicationAdherencePrimaryContentSection(),
          const PatientMedicationAdherenceActionBarSection(),
        ],
      ),
    );
  }
}
