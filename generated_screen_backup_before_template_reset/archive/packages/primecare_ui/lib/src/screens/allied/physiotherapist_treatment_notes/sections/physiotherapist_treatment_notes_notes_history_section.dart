import 'package:flutter/material.dart';

class PhysiotherapistTreatmentNotesNotesHistorySection extends StatelessWidget {
  const PhysiotherapistTreatmentNotesNotesHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('physiotherapist_treatment_notes_notes_history-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Notes History Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
