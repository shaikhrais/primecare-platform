import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_treatment_history_header_section.dart';
import 'sections/patient_treatment_history_filter_bar_section.dart';
import 'sections/patient_treatment_history_data_table_section.dart';
import 'sections/patient_treatment_history_pagination_section.dart';
import 'sections/patient_treatment_history_action_bar_section.dart';

class PatientTreatmentHistoryScreen extends StatelessWidget {
  const PatientTreatmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_treatment_history',
      title: 'Patient Treatment History',
      child: Column(
        children: const [
          const PatientTreatmentHistoryHeaderSection(),
          const PatientTreatmentHistoryFilterBarSection(),
          const PatientTreatmentHistoryDataTableSection(),
          const PatientTreatmentHistoryPaginationSection(),
          const PatientTreatmentHistoryActionBarSection(),
        ],
      ),
    );
  }
}
