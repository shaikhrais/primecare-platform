import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';

class PatientTreatmentHistoryPaginationSection extends StatelessWidget {
  const PatientTreatmentHistoryPaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('patient_treatment_history_pagination-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PrimeText('Pagination Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
